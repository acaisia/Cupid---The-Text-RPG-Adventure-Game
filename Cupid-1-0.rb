
#!/usr/bin/env ruby
#Initialize all Classes
#To start, we will create the classes for in game characters we can interact with
require 'vector2d'
class Sentient
  attr_accessor :my_name, :type, :stride, :x_pos, :y_pos, :region_name, :health_max
  attr_accessor :health_cur, :attack, :exp_gain
  def initialize(type, my_name)
     
  end
end

#Class for player
class Human
  attr_accessor :my_name, :type, :location, :x_pos, :y_pos, :stride
  attr_accessor :fatigue, :level, :cur_exp, :exp_to_next_lvl, :stats, :inventory, :journal
  def initialize
    @stats = Stats.new
    @inventory = Inventory.new
    @journal = Journal.new
  end
end

class Stats
    attr_accessor :strength, :defense, :agility, :vitality, :stamina, :health_max, :health_cur, :attack
    def initialize
      @health_cur = health_cur
    end
  end

## End for entities
#--- Establish Scenes
class Scenes
  attr_accessor :scene_name, :region_name, :enemy_types, :size_total, :size_water, :size_land, :depth_water
  attr_accessor :height_land, :offset_land, :terrain, :description, :seed
  def initialize
end
end


#--- Eastablish BattleScene
class BattleScene
  attr_accessor :number_enemies, :turn, :enemy_type, :enemy_health_max, :enemy_health_cur, :enemy_attack, :exp_gain
end

#--- Establish current scene
class Current_Scene < Scenes
  attr_accessor :current1_scene, :region_name, :x_pos, :y_pos
  def initialize
  end
end

#--- Establish Inventory
### Inventory
class Inventory
  attr_accessor :name, :quantity, :qualifier, :id
  def initialize
    @qualifier = Items.new
  end
end



#--- Establish In Game Interactables
### Items
class Items
  attr_accessor :item_name, :attack_bonus, :health_bonus, :health_gain, :fatigue_sub, :weight
end

#--- Declare Scenes
#361 Total Scenes for the world

Scene1 = Scenes.new
Scene1.scene_name = "Scene: 1"
Scene1.region_name = "Northern Sea of Monsters"
Scene1.enemy_types = "Sea Dragon"
Scene1.seed = 5
Scene1.size_total = 267 * 267
Scene1.size_water = 267 * 267
Scene1.size_land = 0
Scene1.depth_water = 167
Scene1.height_land = 0
Scene1.offset_land = 0
Scene1.terrain = "Sea"
Scene1.description = "To the East, West and North is more sea. To the South you see land."

Scene2 = Scenes.new
Scene2.scene_name = "Scene: 2"
Scene2.region_name = "Northern Sea of Monsters"
Scene2.enemy_types = "Sea Farie Dragons"
Scene2.seed = 7
Scene2.size_total = 267 * 267
Scene2.size_water = 267 * 267
Scene2.size_land = 0
Scene2.depth_water = 180
Scene2.height_land = 0
Scene2.offset_land = 0
Scene2.terrain = "Sea"
Scene2.description = "To the West and North is more sea. To the South you see a bay, to the East you see land."

Scene3 = Scenes.new
Scene3.scene_name = "Scene: 3"
Scene3.region_name = "Northern Sea of Monsters | The Chase Penensula"
Scene3.enemy_types = "Razor Sea Dragons"
Scene3.seed = 3
Scene3.size_total = 267 * 267
Scene3.size_water = 267 * 187
Scene3.size_land = 216 * 120
Scene3.height_land = 1.5
Scene3.offset_land = 187
Scene3.depth_water = 90
Scene3.terrain = "Sea | Beech"
Scene3.description = "To the south, there is a beech. To the North, East and West are endless Seas. The beech looks ominous..."

#Define Journal/History
class Journal
  attr_accessor :page
  def initialize
    @page = []
  end
end

def journal_load(val)
  File.open(val, 'r') do |line|
    if line.include?("Page")
        pager = line.slice("Page")
    else
      Player.journal.page[pager.to_i] = "" if Player.journal.page[pager.to_i] == nil
      Player.journal.page[pager.to_i] += line.to_s
    end
    
  end
end

def journal_save(val)
  write_to = open(val, 'w')
  File.open("#{val}", "a") do |line|
    
    Player.journal.page.each do |pager|
      write_to.write(pager)
      end
      
    end
    
  end

  

#--- Declare World Objects
#--- Declare all world sentients
Player = Human.new()
Player.stride = 50
Player.x_pos = 267/2
Player.y_pos = 267/2
Player.fatigue = 0
Player.level = 0
Player.cur_exp = 0
Player.exp_to_next_lvl = 50
Player.location = 1
Player.inventory.name = []
1000.times {Player.inventory.name << 0}

def op_item(id, val)
if id < 200
  puts "Error: id is not an item."
elsif id > 600
  puts "Error: id is to large for an item."
elsif Player.inventory.name[id.to_i] + val < 0
  Player.inventory.name[id.to_i] = 0; return
elsif Player.inventory.name[id.to_i] + val > 32
  Player.inventory.name[id.to_i] = 32; return
end
Player.inventory.name[id.to_i] += val
end


Player.stats.agility = 10
Player.stats.strength = 25
Player.stats.attack = Player.stats.strength / 5
Player.stats.stamina = 10
Player.stats.vitality = (Player.stats.strength + Player.stats.stamina) * Player.stats.agility
Player.stats.health_max = 50
Player.stats.health_cur = 50
Player.journal.page[1] = "Page 1:"
Player.journal.page[2] = "Page 2:"
Player.journal.page[3] = "Page 3:"

Lakmi = Sentient.new('Demi-God Human', 'Lakmi')
Lakmi.my_name = 'Lakmi'
Lakmi.type = 'Human Demi-God'
Lakmi.stride = 90

Sea_Dragon = Sentient.new('Sea Dragon', 'Enemy')
Sea_Dragon.my_name = 'Enemy'
Sea_Dragon.type = 'Sea Dragon'
Sea_Dragon.stride = 70
Sea_Dragon.region_name = 'Northern Sea of Monsters'
Sea_Dragon.health_max = 25
Sea_Dragon.health_cur = 25
Sea_Dragon.attack = 4
Sea_Dragon.exp_gain = 20

Sea_Farie_Dragon = Sentient.new('Sea Farie Dragon', 'Enemy')
Sea_Farie_Dragon.my_name = 'Enemy'
Sea_Farie_Dragon.type = 'Sea Farie Dragon'
Sea_Farie_Dragon.stride = 10
Sea_Farie_Dragon.region_name = 'Northern Sea of Monsters'
Sea_Farie_Dragon.health_max = 15
Sea_Farie_Dragon.health_cur = 15
Sea_Farie_Dragon.attack = 3
Sea_Farie_Dragon.exp_gain = 15

Razor_Sea_Dragon = Sentient.new('Razor Sea Dragon', 'Enemy')
Razor_Sea_Dragon.my_name = 'Enemy'
Razor_Sea_Dragon.type = 'Razor Sea Dragon'
Razor_Sea_Dragon.stride = 20
Razor_Sea_Dragon.region_name = 'Northern Sea of Monsters | Chase Penensula'
Razor_Sea_Dragon.health_max = 30
Razor_Sea_Dragon.health_cur = 30
Razor_Sea_Dragon.attack = 7
Razor_Sea_Dragon.exp_gain = 30

#--- Declare items

Potion = Items.new
Potion.health_gain = 10
Potion.attack_bonus = 5
Potion.item_name = "Health Potion"
Potion.weight = 1

Dragon_Steak = Items.new
Dragon_Steak.fatigue_sub = 5
Dragon_Steak.health_bonus = 10
Dragon_Steak.item_name = "Dragon Steak"
Dragon_Steak.weight = 1.5

#File methods
Load_Player = Array.new
load_pl = false
line_num = 0

#Methods for file function

def new_game(saver)
  File.open("#{saver}","a") do |line|
    write_to = open(Player.my_name, 'w')
  write_to.write(Player.my_name)
          write_to.write("\n")
          write_to.write(Player.type)
          write_to.write("\n")
          write_to.write(Player.location)
          write_to.write("\n")
          write_to.write(Player.x_pos)
         write_to.write("\n")
         write_to.write(Player.y_pos)
          write_to.write("\n")
         write_to.write(Player.exp_to_next_lvl)
         write_to.write("\n")
          write_to.write(Player.cur_exp)
          write_to.write("\n")
          write_to.write(Player.fatigue)
          write_to.write("\n")
          write_to.write(Player.stats.agility)
          write_to.write("\n")
          write_to.write(Player.stats.attack)
          write_to.write("\n")
          write_to.write(Player.stats.defense)
          write_to.write("\n")
          write_to.write(Player.stats.health_cur)
          write_to.write("\n")
          write_to.write(Player.stats.health_max)
          write_to.write("\n")
          write_to.write(Player.stats.vitality)
          write_to.write("\n")
          write_to.write(Player.inventory.name)
          write_to.write("\n")
          write_to.write(Player.level)
          write_to.write("\n")
  end
end

def load_game(opener)
  line_num = 0
  File.open("#{opener}").each do |line|
    line_num += 1
    Load_Player[line_num] = line.chomp
  end
  Player.my_name = Load_Player[1]
  Player.type = Load_Player[2]
  Player.location = Load_Player[3].to_i
  Player.x_pos = Load_Player[4].to_i
  Player.y_pos = Load_Player[5].to_i
  Player.exp_to_next_lvl = Load_Player[6].to_i
  Player.cur_exp = Load_Player[7].to_i
  Player.fatigue = Load_Player[8].to_i
  Player.stats.agility = Load_Player[9].to_i
  Player.stats.attack = Load_Player[10].to_i
  Player.stats.defense = Load_Player[11].to_i
  Player.stats.health_cur = Load_Player[12].to_i
  Player.stats.health_max = Load_Player[13].to_i
  Player.stats.vitality = Load_Player[14].to_i
  count = 0
  dot = 0
  Load_Player[15].each_char do |item|
    if item == ' '
      puts "Loading files..."
      Player.inventory.name[count.to_i] = dot
      dot = 0
    elsif item.to_i != nil
      count += 1
      dot += item.to_i
  end
  end
  Player.level = Load_Player[16].to_i
  puts "#{Player.my_name}, we have been waiting for you..."
end

#--- Menu
puts "Hello, I am #{Lakmi.my_name}, a #{Lakmi.type}."
# Get Player Name
puts "What is your name adventurer?"
Player.my_name = gets.chomp
if File.exists?("#{Player.my_name}")
  load_game(Player.my_name)
else
   puts "#{Player.my_name}, where do you hail from?"
  Player.type = gets.chomp
  new_game(Player.my_name)
  
           puts "It must be lonely coming all the way from #{Player.type} to Velsaron..."
 puts "Here, take this... The planet of Velsaron is so dastardly... These clothes will keep you warm..."
 puts "Starter Clothing added to inventory!"
end

#check to see if that human already has a file saved.  
 

sleep 10
system("cls")

#Game
Scene = Player.location
end_game = false
input1 = ""
Right_Now = Current_Scene.new
options = ""
battle_end = false
item_find = 0
item_select = ""
item_find_ident = ""
Battle = BattleScene.new
new_place = true
terrain_mult = 0
sleep_on = true
### set up inventory
total_value = 0


while end_game == false
  
  
      if Player.location == 1 && new_place == true
     Right_Now.current1_scene = "#{Player.location} Scene"
     Right_Now.region_name = Scene1.region_name
      Right_Now.seed = rand(Scene1.seed)
      Right_Now.enemy_types = Scene1.enemy_types
      Sea_Dragon.x_pos = rand(267)
      Sea_Dragon.y_pos = rand(267)
      Right_Now.x_pos = Sea_Dragon.x_pos
      Right_Now.y_pos = Sea_Dragon.y_pos
      Right_Now.description = Scene1.description
      Right_Now.depth_water = Scene1.depth_water
      terrain_mult = 0.56
      new_place = false
    end
    if Player.location == 2 && new_place == true
      Right_Now.current1_scene = "#{Player.location} Scene"
      Right_Now.region_name = Scene2.region_name
      Right_Now.seed = rand(Scene2.seed)
      Right_Now.enemy_types = Scene2.enemy_types
      Sea_Farie_Dragon.x_pos = rand(267)
      Sea_Farie_Dragon.y_pos = rand(267)
      Right_Now.x_pos = Sea_Farie_Dragon.x_pos
      Right_Now.y_pos = Sea_Farie_Dragon.y_pos
      Right_Now.description = Scene2.description
      Right_Now.depth_water = Scene2.depth_water
      new_place = false
      terrain_mult = 0.56
    end
    if Player.location == 3 && new_place == true
      Right_Now.current1_scene = "#{Player.location} Scene"
      Right_Now.region_name = Scene3.region_name
      Right_Now.seed = rand(Scene3.seed)
      Right_Now.enemy_types = Scene2.enemy_types
      
        #code
    end
    
    
      puts Right_Now.current1_scene
      puts "(1)-Identify Region, (2)-Move in direction, (3)-Interact with Environment, (4)-Look Around, (5)-Self"
      input1 = gets.chomp
        case input1
        when ""
          puts "#{Lakmi.my_name}: 'Remember, you can exit the game anytime by typing the word Exit.'"
          end_game = false
       
       when "1"
        puts Right_Now.region_name
        end_game = false
      
       when "2"
      puts "Which direction do you wish to move in?"
      puts "(E)ast, (W)est, North, South, Down, Up?"
      move_amt = 0
      direction = gets.chomp
       case direction
        when "E"
          if Player.y_pos == Right_Now.y_pos && Player.x_pos - Player.stride == Right_Now.x_pos
            puts "An enemy is in the way."
          else
            move_amt =  (Player.stride - (Player.fatigue - (Player.stats.agility * 1.5)))
            Player.x_pos += move_amt.abs
          end
          if Player.x_pos >= 267
            Player.location += 1
            Player.x_pos = 0
            new_place = true
          end
        when "W"
          if Player.x_pos - Player.stride == Right_Now.x_pos && Player.y_pos == Right_Now.y_pos
           puts "An enemy is in the way."
          else
            move_amt = (Player.stride - (Player.fatigue - (Player.stats.agility * 1.5)))
            Player.x_pos -= move_amt.abs
          end
          if Player.x_pos << 0
            Player.location -= 1
            Player.x_pos = 266
            new_place = true
          end
          
          
          
        end  
        when "Exit"
        end_game = true
        puts "Game Over"
      
    when "3"
      options = ""
       if Right_Now.seed > 0
         options += "X-Battle #{Right_Now.enemy_types}"
       end
       if Right_Now.depth_water > 0
        options += " Y-Dive to #{Right_Now.depth_water} below the surface"
       end
       if Right_Now.seed > 0
         options += " M-Move to #{Right_Now.enemy_types}"
       end
       
      puts options
      interaction_input = gets.chomp.upcase
      
      when "4"
        puts Right_Now.description
        puts "There are #{Right_Now.seed} number of #{Right_Now.enemy_types}."
        puts "They seem to be at coordinates, #{Right_Now.x_pos}, #{Right_Now.y_pos}"
        
      when "5"
        puts "You examine yourself..."
        puts "Your heatlh is at #{Player.stats.health_cur}."
        puts "Your attack strength is at #{Player.stats.attack}."
        puts "Your fatigue level is at #{Player.fatigue}."
        puts "(C)heck inventory, (S)tats, Sa(V)e, (T)he Journal"
        self_input = gets.chomp.upcase
        end
        
        case self_input
          
        when "T"
          puts "You search yourself and try to locate your journal..."
          if File.exists?("Journal-#{Player.my_name}")
            journal_load("Journal-#{Player.my_name}")
          end
          puts "You pull out your Journal..."
          puts "Pages 2-361 are scene logs. Page 1 is your inventory log."
          puts "What page do you wish to read?"
          self_input = ""
          until self_input == "C" do
            
          self_input = gets.chomp
          
          case self_input
          when "F"
            p_sel += 1
          when "B"
            p_sel -= 1
          when "C"
            self_input = ""
          break
          when "1"
            p_sel = 1
          when "2"
            p_sel = 2
          
        end
          puts Player.journal.page[p_sel.to_i]
          puts "Page (F)orward | Page (B)ackwards | (C)lose Journal  ?"
          self_input = ""
        end
          
        
        when "C"
          cur_inventory = ""
          count = 0
          puts "Your inventory:"
             cur_inventory += "#{Player.inventory.name[200]} Health Potion " if Player.inventory.name[200] >= 1
              cur_inventory += "#{Player.inventory.name[201]} Dragon Steak " if Player.inventory.name[201] >= 1
            
          puts cur_inventory
          puts "Enter the item you wish to use... Leave blank for none."
          puts "Type I-(Item Name) to inspect the item..."
          inv_sel = gets.chomp
          self_input = ""
          
          case inv_sel
            ###Inspect item
          when "I-Health Potion"
            puts "Health Potion:"
            if Player.inventory.name[200] > 0
              puts "Adds, #{Potion.health_gain} points of health."
              puts "Adds, #{Potion.attack_bonus} points to attack."
              puts "Weighs, #{Potion.weight} kilogram."
            else
              puts "You don't have any Health Potions."
            end
            
          when "I-Dragon Steak"
            puts "Dragon Steak:"
            if Player.inventory.name[201] > 0
              puts "Removes, #{Dragon_Steak.fatigue_sub} points of fatigue."
              puts "Adds, #{Dragon_Steak.health_bonus} points of health."
              puts "Weighs, #{Dragon_Steak.weight} kilograms."
            else
              puts "You don't have any Dragon Steaks."
            end
            
            
           ###Use Item 
          when "Health Potion"
            if Player.inventory.name[200] > 0      
          Player.stats.health_cur += Potion.health_gain
          if Player.stats.health_cur > Player.stats.health_max
            Player.stats.health_cur = Player.stats.health_max
          end
          puts "Your health is now at, #{Player.stats.health_cur}!"
        else
          puts "You have no #{Potion.item_name}s."
        end
          
          
        when "Dragon Steak"
          if Player.inventory.name[201] > 0
          
          Player.fatigue -= Dragon_Steak.fatigue_sub
          if Player.fatigue < 0.0
            Player.fatigue = 0.0
          end
          puts "Your fatigue level is now at, #{Player.fatigue}!"
        else
          puts "You have no #{Dragon_Steak.item_name}s."
        end
        end
        
        when "S"
          puts "Your current Level is #{Player.level}, your current Experience is at #{Player.cur_exp}."
          puts "Experience required to next Level is, #{Player.exp_to_next_lvl}."
          puts "Your location is (X,Y); #{Player.x_pos}, #{Player.y_pos}"
          self_input =""
          
        when "V"
          new_game(Player.my_name)
          journal_save("Journal-#{Player.my_name}")
          puts "Saved your information!"
          self_input = ""
          end
        #situation for environment interaction
        case interaction_input
          
        when "M"
          move_amt = Player.x_pos + 0.5 * ((Player.stride-Player.fatigue) + Player.stats.agility) * 1
          move_ang = 0
          move_ang = (Player.x_pos - Right_Now.x_pos) / (Player.y_pos - Right_Now.x_pos)
          Player.x_pos = move_amt + 0.5 * move_ang * move_ang
          Player.y_pos = move_amt + 0.5 * move_ang * move_ang
          puts "You have moved towards the #{Right_Now.enemy_types}."
          puts Player.x_pos
          puts Player.y_pos
          puts Right_Now.x_pos
          puts Right_Now.y_pos
          
          when "X"
          
          Battle.number_enemies = Right_Now.seed
          Battle.enemy_type = Right_Now.enemy_types
          Battle.turn = 0
           if Battle.number_enemies > 0
            battle_end = false
          else
            battle_end = true
            end
          
           if Player.location == 1
            Battle.enemy_health_max = Sea_Dragon.health_max
            Battle.enemy_attack = Sea_Dragon.attack
            Battle.enemy_health_cur = Sea_Dragon.health_cur
            Battle.exp_gain = Sea_Dragon.exp_gain
          end
           if Player.location == 2
             Battle.enemy_health_max = Sea_Farie_Dragon.health_max
             Battle.enemy_attack = Sea_Farie_Dragon.attack
             Battle.enemy_health_cur = Sea_Farie_Dragon.health_cur
             Battle.exp_gain = Sea_Farie_Dragon.exp_gain
           end
           Player.journal.page[Player.location + 1] = "Page 2:\n #{Right_Now.current1_scene};\n #{Player.my_name} had an encounter with #{Battle.enemy_type} at #{Time.now}, #{Player.x_pos}, #{Player.y_pos}." if Player.journal.page[1] == ""
           Player.journal.page[Player.location + 1] += "\n #{Player.my_name} had an encounter with #{Battle.enemy_type} at #{Time.now}, #{Player.x_pos}, #{Player.y_pos}." if Player.journal.page[1] != ""
            puts "Journal Entry added." 
           
          while battle_end == false
            attack_cur = 0
                       
            puts "#{Battle.number_enemies} #{Battle.enemy_type}"
            puts "You have, #{Player.stats.health_cur} of #{Player.stats.health_max} health points."
            puts "The enemy has #{Battle.enemy_health_cur} of #{Battle.enemy_health_max} health points."
            puts "(A) Attack; (R) Run."
            battle_choice = gets.chomp
            
            case battle_choice
             when "A"
               if Right_Now.seed > 0               
              attack_cur = rand(Player.stats.attack) + 0.5
              Player.journal.page[Player.location + 1] += "\n #{Player.my_name} felt very strong and able to defeat the enemy #{Battle.enemy_type} inflicting #{Player.stats.attack / attack_cur} of his full attack on the enemy!"
              Player.journal.page[Player.location + 1] += "\n There was a sound of bone breaking from the enemy!" if (Player.stats.attack / attack_cur) >= 6
              Player.journal.page[Player.location + 1] += "\n There was little effort to harm the enemy in #{Player.my_name}'s attempt!" if (Player.stats.attack / attack_cur) <= 5
              Battle.enemy_health_cur -= attack_cur
              puts "You inflict #{attack_cur} of damage on #{Battle.enemy_type}"
              attack_cur = rand(Battle.enemy_attack) + 0.5
              Player.journal.page[Player.location + 1] += "\n #{Player.my_name} felt freight from the pressence of the enemy #{Battle.enemy_type} as he took #{attack_cur} damage!" if (Battle.enemy_health_cur / Battle.enemy_health_max) >= 0.5
              Player.journal.page[Player.location + 1] += "\n #{Player.my_name} had no fears when recieving #{attack_cur} damage." if Battle.enemy_health_cur / Battle.enemy_health_max <= 0.4
              Player.stats.health_cur -= attack_cur
              puts "#{Battle.enemy_type} inflicts #{attack_cur} of damage on you."
              Player.fatigue += 0.5
            else
            puts "There are no enemies to fight..."
            battle_end = true
          end
              
            
             when "R"
               battle_end = true
                interaction_input = ""
               puts "You have ran away."
               battle_choice = ""
             end
            
             if Battle.enemy_health_cur <= 0
               battle_end = true
               puts "The battle is over..."
               interaction_input = ""
               battle_choice = ""
               Player.journal.page[Player.location + 1] += "\n #{Player.my_name} defeated the enemy #{Battle.enemy_type} at #{Time.now}!"
               Player.cur_exp += Battle.exp_gain
               puts "You gained, #{Battle.exp_gain} experience points."
               item_find = rand(10)
               Right_Now.seed -= 1
               Player.journal.page[Player.location + 1] += "\n Thus clearing #{Right_Now.current1_scene}." if Right_Now.seed == 0
               puts "There are #{Right_Now.seed} enemy #{Battle.enemy_type} left."
               if item_find >= 5
                 puts "You found a #{Dragon_Steak.item_name}!"
                op_item(201,1)
                puts "#{Dragon_Steak.item_name} added to inventory."
                Player.journal.page[1] += "\n Inventory Log;\n Dragon Steak added to inventory! \n Dragon Steak now at #{Player.inventory.name[201]}!"
               end
               puts "Journal entry logged."
             end
             if Player.stats.health_cur == 0
               end_game = true
                 battle_end = true
                 puts "You have died to #{Battle.enemy_type}"
                 interaction_input = ""
                 battle_choice = ""
               end
           end
       
          when "Y"
            interaction_input = ""
            puts "You dive to the bottom of the sea at #{Right_Now.depth_water} kilometers."
            puts "You find..."
            item_find = rand(3)
            if item_find > 2
              item_find_ident = Potion.item_name
            end
            
            puts "#{item_find} #{item_find_ident}!"
            
           if Player.inventory.name[200] >= 32
             puts "You have max #{item_find_ident}."
            else
              op_item(200,1)
              puts "#{item_find_ident} added to inventory."
              Player.journal.page[1] = "Page:1" if Player.journal.page[1] == ""
              Player.journal.page[1] = "\n #{Player.my_name} found #{item_find} #{item_find_ident} at #{Right_Now.depth_water} below the surface. #{Time.now}"
            end
           end
        ###Allocate Fatigue to Human
        Player.fatigue += (Player.stats.stamina / (Player.stats.attack - 10)) * terrain_mult
        Player.fatigue = Player.fatigue.abs
        ###Put system in sleep for 15 seconds
        if sleep_on == true
            sleep 15
        end
        
        ### Clear the screen and check to see if the Human has leveled up
        system("cls")
        level_up = false
        if Player.cur_exp >= Player.exp_to_next_lvl
          level_up = true
        end
        
        if level_up == true
          Player.level += 1
          Player.exp_to_next_lvl *= 2
          puts "Congratulations!"
          sleep 1
          puts "You have leveled up to Level: #{Player.level}"
          next_lvl = Player.exp_to_next_lvl - Player.cur_exp
          puts "You only need, #{next_lvl} more Experience!"
        end
        ###update Journal file
        journal_save("Journal-#{Player.my_name}")
        ###Move the entities around.
          end
        
                
          
