God.watch do |w|
  w.name = "smsreader"
  w.start = "ruby /Users/kyle/dev/ruby-tests/smstool/smsdread.rb"
  w.keepalive
end