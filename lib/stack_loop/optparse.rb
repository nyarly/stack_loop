require 'optparse'

module StackLoop
  class OptParse < OptionParser
    def initialize(app)
      @app = app
      super do |opti|
        opti.banner = "Usage: #$0 [options]"

        opti.on("-c", "--command COMMAND", "The command string prefix to run") do |command|
          app.command = command
        end

        opti.on("-s", "--stack-file FILE", "The file to read for argument sets") do |stack|
          app.stack_file = stack
        end

        opti.on("-p", "--push-file FILE", "A path to read for new argument sets") do |file|
          app.collect_file = file
        end

        opti.on("-d", "--default FILE", "Argument to use if the stack is empty") do |default|
          app.default_args = default
        end

        opti.on_tail("-h", "--help", "Show this message") do
          puts opti
          exit
        end
      end
    end
  end
end
