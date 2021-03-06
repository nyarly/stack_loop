Gem::Specification.new do |spec|
  spec.name		= "stack_loop"
  spec.version		= "0.1.0"
  author_list = {
    "Judson Lester" => 'nyarly@gmail.com'
  }
  spec.authors		= author_list.keys
  spec.email		= spec.authors.map {|name| author_list[name]}
  spec.summary		= "Run related commands in a loop"
  spec.description	= <<-EndDescription
  The idea here is to take arguments off of a stack, run a command, and proceed down the stack iff the command
  exits 0.

  Why? Consider running rspec with a tight focus, adding breadth on success
  EndDescription

  spec.rubyforge_project= spec.name.downcase
  spec.homepage        = "http://nyarly.github.com/#{spec.name.downcase}"
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  # Do this: y$@"
  # !!find lib bin doc spec spec_help -not -regex '.*\.sw.' -type f 2>/dev/null
  spec.files		= %w[
    lib/stack_loop/app.rb
    lib/stack_loop/optparse.rb
    bin/stack_loop
  ]

  spec.test_file        = "spec_help/gem_test_suite.rb"
  spec.licenses = ["MIT"]
  spec.require_paths = %w[lib/]
  spec.rubygems_version = "1.3.5"

  spec.has_rdoc		= true
  spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} Documentation"]
  spec.executables << "stack_loop"

  #spec.add_dependency("", "> 0")

  #spec.post_install_message = "Thanks for installing my gem!"
end
