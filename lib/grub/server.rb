module Grub
  # server for grub
  module Server
    class << self
      # serve file with webrick
      def serve(file, port = 9090)
        server = WEBrick::HTTPServer.new(
          Port:         port,
          DocumentRoot: File.dirname(file),
          Logger:       WEBrick::Log.new(File.open(File::NULL, 'w')),
          AccessLog:    []
        )
        template = read_asset('webpage.erb')

        server.mount_proc("/#{File.basename(file)}") do |_, res|
          pipeline = HTML::Pipeline.new [
            HTML::Pipeline::MarkdownFilter,
            HTML::Pipeline::SanitizationFilter,
            HTML::Pipeline::SyntaxHighlightFilter
          ], { unsafe: true }

          # render markdown from file
          result   = pipeline.call(File.read(file))
          rendered = result[:output].to_s

          res.body = ERB.new(template).result(binding)
        end

        # serve github markdown css
        server.mount_proc('/markdown.css') do |_, res|
          res.body = read_asset('markdown.css')
        end

        # shutdown server on SIGINT
        trap 'INT' do
          server.shutdown
        end

        url = "http://localhost:#{port}/#{File.basename(file)}"

        print_box(file, url)
        Clipboard.copy(url)

        server.start
      end

      # print box for served file
      def print_box(file, url)
        # length of messages in box
        file_length   = 8 + tilde(file).length
        link_length   = 8 + url.length

        max_length = [8, file_length, link_length, 25].max

        # padding for messages
        title_padding  = ' ' * (max_length - 8)
        file_padding   = ' ' * (max_length - file_length)
        link_padding   = ' ' * (max_length - link_length)
        copied_padding = ' ' * (max_length - 25)

        # print box
        puts "   ┌#{'─' * (max_length + 6)}┐".green
        puts "   │#{' ' * (max_length + 6)}│".green
        puts "   #{'│'.green}   #{'Serving!'.green.bold}#{title_padding}   #{'│'.green}"
        puts "   │#{' ' * (max_length + 6)}│".green
        puts "   #{'│'.green}   • #{'File:'.bold} #{tilde(file)}#{file_padding}   #{'│'.green}"
        puts "   #{'│'.green}   • #{'Link:'.bold} #{url}#{link_padding}   #{'│'.green}"
        puts "   │#{' ' * (max_length + 6)}│".green
        puts "   #{'│'.green}   Copied link to clipboard!#{copied_padding}   #{'│'.green}"
        puts "   │#{' ' * (max_length + 6)}│".green
        puts "   └#{'─' * (max_length + 6)}┘".green
        puts
      end
    end
  end
end
