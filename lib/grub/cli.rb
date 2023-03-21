module Grub
  # grub cli
  module CLI
    class << self
      # run cli with argv
      def run(argv)
        file = argv[0]
        help unless file

        # ensure file exists
        error "file `#{file.tilde}` does not exist" unless File.exist?(file)

        # run server
        if argv[1]
          Grub::Server.serve(file, argv[1])
        else
          Grub::Server.serve(file)
        end
      end

      # show help and exit
      def help
        puts <<~HELP
          #{'usage'.magenta.bold}:
            #{'grub'.cyan} #{'<file>'.yellow} #{'[<port>]'.yellow}

          #{'examples'.magenta.bold}:
            #{'grub'.cyan} #{'README.md'.yellow}       serve README.md on localhost:9090
            #{'grub'.cyan} #{'README.md'.yellow} #{'8080'.yellow}  serve README.md on localhost:8080
        HELP

        exit 0
      end
    end
  end
end
