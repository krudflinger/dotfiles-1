# === EDITOR ===
Pry.editor = 'vim'

## Useful Collections
def a_array
  (1..6).to_a
end

def a_hash
  {hello: "world", free: "of charge"}
end

# Pry.config.pager = true
# Pry.config.editor = "emacs"
Pry.config.color = true
Pry.config.prompt = Pry::NAV_PROMPT
#Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

Pry.config.commands.alias_command "h", "hist -T 20", desc: "Last 20 commands"
Pry.config.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.config.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.config.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"
# == Pry-Nav - Using pry as a debugger ==
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

begin
  require 'awesome_print'
  # Pry.config.print = proc { |output, value| output.puts value.ai }
  AwesomePrint.pry!
rescue LoadError => err
  puts "no awesome_print :("
end

my_hook = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  dir = `pwd`.chomp
  dirs_added = []
  %w(spec test).map{ |d| "#{dir}/#{d}" }.each do |p|
    if File.exist?(p) && !$:.include?(p)
      $: << p
      dirs_added << p
    end
  end
  puts "Added #{ dirs_added.join(", ") } to load path in ~/.pryrc." if dirs_added.present?
end

my_hook.exec_hook(:before_session)

puts "Loaded ~/.pryrc"
puts
puts "Helpful shortcuts:"
puts "h  : hist -T 20       Last 20 commands"
puts "hg : hist -T 20 -G    Up to 20 commands matching expression"
puts "hG : hist -G          Commands matching expression ever used"
puts "hr : hist -r          hist -r <command number> to run a command"
puts
puts "c  : continue"
puts "s  : step"
puts "n  : next"
puts "r!  : reload!"
puts
puts "Samples variables"
puts "a_array  :  [1, 2, 3, 4, 5, 6]"
puts "a_hash   :  { hello: \"world\", free: \"of charge\" }"
