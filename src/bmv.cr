require "crouton"

module Bmv
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end

def banner
  "usage: bmv [flags] target source"
end

def history_parse(history : String)
  args = history
    .lines
    .map(&.split(" ")[5..-1].join(" "))
    .reverse
    .select!(&.starts_with?("mv "))
    .first
    .split(" ")
    .[1..-1]
  puts "args were: #{args}"
  doit(args)
end

unless STDIN.tty?
  STDERR.puts "If you didn't pass history, you're doing this wrong."
  STDERR.puts "Did you?"
  tty = File.open("/dev/tty")
  answer = tty.gets
  if %w(yes y true t 1).includes?(answer.try(&.downcase))
    history_parse(STDIN.gets_to_end)
    exit 0
  end
  exit 1
end

def doit(argv)
  flags = [] of String
  argv.each do |x|
    case x
    when .match(/-[a-zA-Z0-9]/)
      flags << x
    when .match(/--[a-zA-Z0-9].*/)
      flags << x
    end
  end

  arguments = argv - flags

  if arguments.size > 2
    STDERR.puts(banner)
    STDERR.puts("multiple moves are unsupported")
    exit 1
  end

  if arguments.size < 2
    STDERR.puts(banner)
    STDERR.puts("a target and source are required")
    exit 1
  end

  target = arguments[0]
  source = arguments[1]

  mv_args = flags + [source, target]
  Process.exec(
    command: "mv",
    args: mv_args,
  )
end

doit(ARGV)
