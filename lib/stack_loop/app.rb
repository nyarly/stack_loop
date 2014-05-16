require 'abbrev'

module StackLoop
  class App
    class Command
      attr_accessor :name, :desc

      def initialize(name, desc=nil, &action)
        @name = name
        @desc = desc
        @action = action
      end

      def run
        @action.call
      end
    end

    def commands
      [
        Command.new("run"){ run_stack_loop },
        Command.new("collect"){ push_new; run_stack_loop },
        Command.new("pop"){ pop_argset },
        Command.new("quit"){ raise "Quitting!" },
        Command.new("help"){ puts "Don't know that one - try: #{command_names.join(", ")}" }
      ]
    end

    attr_accessor :command, :stack_file, :collect_file, :default_args

    def initialize
      @default_args = ""
    end

    def validate_options!
      raise "Need a command!" if command.nil?
      raise "Need a stack file!" if stack_file.nil?
    end

    def push_new
      unless collect_file.nil?
        push_argset File::read(collect_file).split("\n")
      end
    end

    def read_stack
      stack_string = File.read(stack_file)
      @stack = stack_string.split("\n\n").map do |item|
        item.split("\n")
      end.reject do |item|
        item.empty?
      end
    rescue Errno::ENOENT
      @stack = []
    end

    def write_stack
      File::write(stack_file, @stack.map do |argset|
        argset.join("\n")
      end.join("\n\n") + "\n")
    end

    def get_argset
      read_stack
      if @stack.empty?
        [default_args]
      else
        @stack.last
      end
    end

    def push_argset(args)
      read_stack
      @stack.push(args)
      write_stack
    end

    def pop_argset
      read_stack
      @stack.pop
      write_stack
    end

    def stack_depth
      read_stack
      @stack.length
    end

    def run
      validate_options!

      puts "Starting with: " + current_command_line.join(" ")
      puts
      run_stack_loop

      abbreviations = Abbrev.abbrev(command_names)

      loop do
        prompt
        command_name = $stdin.gets.chomp
        if command_name.empty?
          command_name = "run"
        end

        command_name = abbreviations[command_name]
        command = command_hash.fetch(command_name, command_hash["help"])
        puts "\n#{__FILE__}:#{__LINE__} => #{command.inspect}"
        command.run
      end
    end

    def command_list
      @command_list ||= command.split(/\s/)
    end

    def current_command_line
      args = get_argset

      command_list + get_argset
    end

    def prompt
      puts
      puts "Next: " + current_command_line.join(" ")
      print "#{stack_depth} > "
    end

    def command_names
      @command_names ||= command_hash.keys
    end

    def command_hash
      @command_hash ||= Hash[ commands.map{|cmd| [cmd.name, cmd] } ]
    end

    def run_stack_loop
      while run_stack
        puts
        puts "Success - running again..."
        puts
      end
    end

    def run_stack
      success = system(*current_command_line)

      if success.nil?
        raise "#{[command, *args].inspect} couldn't be run"
      end
      pop_argset if success

      return false if @stack.empty?

      return success
    end
  end
end
