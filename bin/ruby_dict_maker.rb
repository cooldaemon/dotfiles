#!/usr/bin/ruby -w

ary = []

ARGV.each do |arg|
  File.open(arg) do |io|
    while text = io.gets do
      if /^full_name/ =~ text
        if m = /^full_name:\s(\w+)(?:#|::)(\w+[!?]?)/.match(text)
          ary.concat(m.captures)
        else
          STDERR.print "Skipped: #{arg}: #{text}"
        end
      end
    end
  end
end

ary.uniq.sort.each do |line|
  puts line
end

