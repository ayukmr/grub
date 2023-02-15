module Grub
  # cli for grub
  module CLI
    class << self
      # run cli with argv
      def run(argv)
        file = argv[0]
        help unless file

        # ensure file exists
        file = File.expand_path(file)
        error "file `#{tilde(file)}` does not exist", 1 unless File.exist?(file)

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
          #{'Usage'.magenta.bold}:
            #{'grub'.cyan} #{'<FILE>'.yellow} #{'[PORT]'.yellow}

          #{'Examples'.magenta.bold}:
            #{'grub'.cyan} #{'README.md'.yellow}       serve README.md on localhost:9090
            #{'grub'.cyan} #{'README.md'.yellow} #{'8080'.yellow}  serve README.md on localhost:8080
        HELP

        exit 0
      end
    end
  end
end
