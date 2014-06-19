require 'artoo'

connection :sphero, adaptor: :sphero, port: '/dev/cu.Sphero-ROB-AMP-SPP'
device :sphero, driver: :sphero

work do
  on sphero, collision: :react_to_collision

  wander_listlessly
end

def react_to_collision(*args)
  args.each do |arg|
    puts "Argument 1: #{arg.inspect}"
  end
  sphero.set_color :red
  sphero.stop

  @collision_count ||= 0
  @collision_count += 1
  puts "Collisions detected #{@collision_count}"

  reverse

  sphero.set_color :yellow
end

def reverse(speed = 100)
  sphero.roll speed, 180
end

def wander_listlessly(duration = 3.seconds)
  @count = 1
  every duration do
    sphero.set_color rand(255), rand(255), rand(255)
    @count += 1
    sphero.roll 90, rand(360)
  end
end

