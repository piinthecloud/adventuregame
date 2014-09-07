class Garden
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections, items)
    @rooms << Room.new(reference, name, description, connections, items)
  end

#sets locationa attribute
  def start(location)
    @player.location = location
    show_current_description
  end

#method which finds the room based on player location, also prints location to
#screen
  def show_current_description
    puts current_room.full_description
  end

  def find_room_in_garden(reference)
    @rooms.detect { |room| room.reference == reference}
  end

  def find_room_in_direction(direction)
    current_room.connections[direction]
  end

  def go(direction)
    puts "You went " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  def possible_exits
    current_room.connections.keys
  end

  def current_room
    find_room_in_garden(@player.location)
  end

  def can_go?(direction)
    possible_exits.include?(direction)
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections, :items

    def initialize(reference, name, description, connections, items)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
      @items = items
    end

  #Method to show player which items are available to pick up.
    # def pickup(items)
    #   current_room.items.keys
    # end

    def full_description
      puts @name + "\nYou are in " + @description
      puts "You can go:"
      puts @connections.keys
      puts "=>This room has a:"
      puts @items
    end
  end
end



#create the main garden object
puts "Welcome to My Garden. What's your name?"
name = gets.chomp
puts "*"*80
my_garden = Garden.new(name)


#add rooms to garden
my_garden.add_room(:gazebo, "\nGazebo", "a cute gazebo. \nLook around.", {north: :smalllawn, east: :duckpond}, :lantern)
my_garden.add_room(:smalllawn, "\nSmall Lawn", "a small adorable  lawn.", {east: :rosegarden, south: :gazebo}, :picnic_table)
my_garden.add_room(:rosegarden, "\nRose Garden", "a lovely rose garden.", {south: :duckpond, west: :smalllawn}, :flower)
my_garden.add_room(:duckpond, "\nDuck Pond", "a pond full of ducks.", {west: :gazebo, north: :rosegarden}, :duck)

#Start Garden by placing the player in the large
my_garden.start(:gazebo)


while true
  puts "*"*80
  puts "What direction do you want to go next?"
  direction = gets.chomp.downcase.to_sym
  case direction
  when :east, :west, :north, :south
    if  my_garden.can_go?(direction)#the user can go in the direction they put in, then
      my_garden.go(direction)
    else
      puts "That's not a direction you can go in. Try going: #{my_garden.possible_exits}"
    end
  else
     puts "\nTry typing in North, South, East, or West."
  end
  if direction == :exit
    break
  end
    # if direction == nil
    #   puts "Thats not an option. Try going a different way."
    # end
    # if ![:east, :west, :south, :north].include? direction
    #   puts "\nThats not an option. Try going a different way."
    # end
end

# case direction
# when :east, :west, :north, :south
#   if  my_garden.can_go?(direction)#the user can go in the direction they put in, then
#     my_garden.go(direction)
#   else
#     puts "That's not a direction you can go in. Try going: #{my_garden.possible_exits}"
#   end
# else
#    puts "\nTry typing in North, South, East, or West."
# end
