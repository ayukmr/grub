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
        template = read_asset('template.erb')

        server.mount_proc("/#{File.basename(file)}") do |_, res|
          filters = [
            HTML::Pipeline::MarkdownFilter,
            HTML::Pipeline::SanitizationFilter,
            HTML::Pipeline::SyntaxHighlightFilter
          ]

          pipeline = HTML::Pipeline.new(filters, { unsafe: true })

          # render markdown from file
          result   = pipeline.call(File.read(file))
          rendered = result[:output].to_s

          res.body = ERB.new(template).result(binding)
        end

        # serve github markdown css
        server.mount_proc('/markdown.css') do |_, res|
          res.body = read_asset('markdown.css')
        end

        # shutdown server on sigint
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
        file_length = 8 + file.tilde.length
        link_length = 8 + url.length

        max_length = [8, file_length, link_length, 25].max

        puts "   ╭#{'─' * (max_length + 6)}╮".green
        puts "   │#{' ' * (max_length + 6)}│".green

        # serving message
        puts "   #{'│'.green}   #{'Serving!'.ljust(max_length).green.bold}   #{'│'.green}"

        puts "   │#{' ' * (max_length + 6)}│".green

        # file and link messages
        puts "   #{'│'.green}   • #{'File:'.bold} #{file.tilde.ljust(max_length - 8)}   #{'│'.green}"
        puts "   #{'│'.green}   • #{'Link:'.bold} #{url.ljust(max_length - 8)}   #{'│'.green}"

        puts "   │#{' ' * (max_length + 6)}│".green

        # clipboard message
        puts "   #{'│'.green}   #{'Copied link to clipboard!'.ljust(max_length)}   #{'│'.green}"

        puts "   │#{' ' * (max_length + 6)}│".green
        puts "   ╰#{'─' * (max_length + 6)}╯".green
      end
    end
  end
end
