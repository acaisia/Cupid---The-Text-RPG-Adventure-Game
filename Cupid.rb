
#!/usr/bin/env ruby
#Initialize all Classes
#To start, we will create the classes for in game characters we can interact with
class Sentient
  attr_accessor :my_name, :type, :stride, :x_pos, :y_pos, :region_name, :health_max
  attr_accessor :health_cur, :attack, :exp_gain
  def initialize(type, my_name)
     
  end
end

#Class for player
class Human
  attr_accessor :my_name, :type, :location, :x_pos, :y_pos, :stride
  attr_accessor :fatigue, :level, :cur_exp, :exp_to_next_lvl, :stats
  def initialize
    @stats = Stats.new 
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
inventory_player = ["Health Potion", "Dragon Steak"]
#--- Establish In Game Interactables
### Items
class Items
  attr_accessor :item_name, :attack_bonus, :health_bonus, :health_gain, :fatigue_sub
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

Player1 = Stats.new
Player1.agility = 10
Player1.strength = 25
Player1.attack = Player1.strength / 5
Player1.stamina = 10
Player1.vitality = (Player1.strength + Player1.stamina) * Player1.agility
Player1.health_max = 50
Player.stats.health_cur = 50


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

#--- Declare items

Potion = Items.new
Potion.health_gain = 10
Potion.attack_bonus = 5
Potion.item_name = "Health Potion"

Dragon_Steak = Items.new
Dragon_Steak.fatigue_sub = 5
Dragon_Steak.health_bonus = 10
Dragon_Steak.item_name = "Dragon Steak"

#File methods
Load_Player = Array.new
load_pl = false
line_num = 0

#--- Menu
puts "Hello, I am #{Lakmi.my_name}, a #{Lakmi.type}."

#check to see if that human already has a file saved.
if File.exist?('save')
  File.open('save').each do |line|
    line_num += 1
    Load_Player[line_num] = line.chomp
  end
  load_pl = true
end
if load_pl == true
  Player.my_name = Load_Player[1]
  Player.type = Load_Player[2]
  Player.location = Load_Player[3].to_i
  Player.x_pos = Load_Player[4].to_i
  Player.y_pos = Load_Player[5].to_i
  Player.exp_to_next_lvl = Load_Player[6].to_i
  Player.cur_exp = Load_Player[7].to_i
  Player.fatigue = Load_Player[8].to_i
  Player1.agility = Load_Player[9].to_i
  Player1.attack = Load_Player[10].to_i
  Player1.defense = Load_Player[11].to_i
  Player.stats.health_cur = Load_Player[12].to_i
  Player1.health_max = Load_Player[13].to_i
  Player1.vitality = Load_Player[14].to_i
  inventory_player = Load_Player[15]
  Player.level = Load_Player[16].to_i
  puts "#{Player.my_name}, we have been waiting for you..."
end
  if load_pl == false
  puts "What is your name adventurer?"
  Player.my_name = gets.chomp
  puts "#{Player.my_name}, where do you hail from?"
  Player.type = gets.chomp
  save = File.new("save", "w")
  write_to = open(save, 'w')
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
          write_to.write(Player1.agility)
          write_to.write("\n")
          write_to.write(Player1.attack)
          write_to.write("\n")
          write_to.write(Player1.defense)
          write_to.write("\n")
          write_to.write(Player.stats.health_cur)
          write_to.write("\n")
          write_to.write(Player1.health_max)
          write_to.write("\n")
          write_to.write(Player1.vitality)
          write_to.write("\n")
          write_to.write(inventory_player)
          write_to.write("\n")
          write_to.write(Player.level)
          write_to.write("\n")
  end
 puts "It must be lonely coming all the way from #{Player.type} to Velsaron..."
 puts "Here, take this... The planet of Velsaron is so dastardly... This implant will allow you to keep everything you collect..."
 puts "Implant received! +99 to all inventory for ever!"
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
            move_amt =  (Player.stride - (Player.fatigue - (Player1.agility * 1.5)))
            Player.x_pos += move_amt.abs
          end
          if Player.x_pos >= 267
            Player.location += 1
            Player.x_pos = 0
            new_place = true
          end          
        end  
        when "Exit"
        end_game = true
        puts "Game Over"
      
    when "3"
      options = ""
       if Right_Now.seed >> 0
         options += "X-Battle #{Right_Now.enemy_types}"
       end
       if Right_Now.depth_water >> 0
        options += "Y-Dive to #{Right_Now.depth_water} below the surface."
       end
      puts options
      interaction_input = gets.chomp
      
      when "4"
        puts Right_Now.description
        puts "There are #{Right_Now.seed} number of #{Right_Now.enemy_types}."
        puts "They seem to be at coordinates, #{Right_Now.x_pos}, #{Right_Now.y_pos}"
        
      when "5"
        puts "You examine yourself..."
        puts "Your heatlh is at #{Player.stats.health_cur}."
        puts "Your attack strength is at #{Player1.attack}."
        puts "Your fatigue level is at #{Player.fatigue}."
        puts "(C)heck inventory, (S)tats, Sa(V)e"
        self_input = gets.chomp
        end
        case self_input
          
        when "C"
          puts "Your inventory:"
          puts inventory_player
          puts "Enter the item you wish to use... Leave blank for none."
          inv_sel = gets.chomp
          self_input = ""
          
          case inv_sel
          when "Health Potion"
          Player.stats.health_cur += Potion.health_gain
          if Player.stats.health_cur >> Player1.health_max
            Player.stats.health_cur = Player1.health_max
          end
          
        when "Dragon Steak"
          Player.fatigue -= Dragon_Steak.fatigue_sub
          if Player.fatigue << 0.0
            Player.fatigue = 0.0
          end
          
          end
        when "S"
          puts "Your current Level is #{Player.level}, your current Experience is at #{Player.cur_exp}."
          puts "Experience required to next Level is, #{Player.exp_to_next_lvl}."
          puts "Your current Level is: #{Player.level}."
          puts "Your location is (X,Y); #{Player.x_pos}, #{Player.y_pos}"
          self_input =""
          
        when "V"
          save = File.new("save", "w+")
          write_to = open(save, 'w+')
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
          write_to.write(Player1.agility)
          write_to.write("\n")
          write_to.write(Player1.attack)
          write_to.write("\n")
          write_to.write(Player1.defense)
          write_to.write("\n")
          write_to.write(Player.stats.health_cur)
          write_to.write("\n")
          write_to.write(Player1.health_max)
          write_to.write("\n")
          write_to.write(Player1.vitality)
          write_to.write("\n")
          write_to.write(inventory_player)
          write_to.write("\n")
          write_to.write(Player.level)
          write_to.write("\n")
          puts "Saved your information!"
          self_input = ""
          end
        case interaction_input
        when "X"
          
          Battle.number_enemies = Right_Now.seed
          Battle.enemy_type = Right_Now.enemy_types
          Battle.turn = 0
           if Battle.number_enemies >> 0
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
           
          while battle_end == false
            attack_cur = 0
            puts "#{Battle.number_enemies} #{Battle.enemy_type}"
            puts "You have, #{Player.stats.health_cur} of #{Player1.health_max} health points."
            puts "The enemy has #{Battle.enemy_health_cur} of #{Battle.enemy_health_max} health points."
            puts "(A) Attack; (R) Run."
            battle_choice = gets.chomp
            
            case battle_choice
             when "A"
               if Right_Now.seed >> 0               
              attack_cur = rand(Player1.attack)
              Battle.enemy_health_cur -= attack_cur
              puts "You inflict #{attack_cur} of damage on #{Battle.enemy_type}"
              attack_cur = rand(Battle.enemy_attack)
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
               Player.cur_exp += Battle.exp_gain
               puts "You gained, #{Battle.exp_gain} experience points."
               item_find = rand(10)
               Right_Now.seed -= 1
               puts "There are #{Right_Now.seed} enemy #{Battle.enemy_type} left."
               if item_find >= 5
                 puts "You found a #{Dragon_Steak.item_name}!"
                 puts "Added to inventory!"
                 if inventory_player.include?('Dragon Steak') == false
                   inventory_player.push("Dragon Steak")
                 end
               end
               
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
            if item_find >> 2
              item_find_ident = Potion.item_name
            end
            
            puts "One #{item_find_ident}!"
            puts "#{item_find_ident} added to inventory."
           if inventory_player.include?(item_find_ident)
             puts "You alredy have #{item_find_ident}"
            else
              inventory_player.push = [item_find_ident]
            end
           end
        Player.fatigue += (Player1.stamina / (Player1.attack - 10)) * terrain_mult
        Player.fatigue = Player.fatigue.abs
        if sleep_on == true
            sleep 15
        end
        
        
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
        
          end
        
                
          
