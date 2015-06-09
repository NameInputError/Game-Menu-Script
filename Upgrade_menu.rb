class Class_Upgrade_Help
  
  def initialize(index)
    @index = index
    @description = ""
  end
  
  def description
    case @index
    when 0
    @description = "Upgrade skills from your current class, or skills\nthat you have permanently learned."
    
    when 1
    @description = "View skills that you can learn, or may be able to\nlearn soon."
    
    when 2
    @description = "Upgrade your base stats."
  end
end
end

class Upgrade_Message < Window_Selectable
  attr_accessor :context

  def initialize(x,y,width,height)
    super(x,y,width,height)
    @item = nil
    z = 999
  end

  def get_item(item, context)   #takes item
    @item = item
    @context = context
    contents.clear
    show
    activate
    display
  end
  
  def display
    case @context
      when "upgrade"
        draw_text(0,0,300,28, "You upgraded #{@item.name}!")
        RPG::SE.new("Chime2", 300, 150).play
      when "learn"
        draw_text(0,0,300,28, "You learned #{@item.name}!")
        RPG::SE.new("Chime2", 300, 150).play
      when "stat"
        draw_text(0,0,300,28, "You increased your #{@item.name}!")
        RPG::SE.new("Chime2", 300, 150).play
    end
  end
  
  def display_smith_error
    @context = "learn"
    draw_text(0,0,300,28, "You must permanently learn")
    draw_text(0,24,300,28, "Magicsmithing first.")
  end
end

class Skill_Upgrade_Help
  
  def initialize(item)
    @item = item
    @description = ""
  end
  
  #205 (holy seal) increases turn speed
  
  def description
    unless @item == nil
      id = $game_party.menu_actor.id
      @description = "Current Level: #{@item.lvl(id)}                  Upgrade Cost: #{@item.upgrade_cost(id)}\n" +
          "Next Level: "
      case @item.id
        when 267
          @description += "Power Increase: #{(@item.get_upgrade_power2(id) * 100).to_i}%"
        when 220
          @description += "New MP Cost: #{@item.get_upgrade_reduction(id)}"
        when 144
          @description += "#{(@item.get_upgrade_power(id) * 100).to_i}% better steal chance."
        when 477
          @description += "Added AGI on use: #{@item.get_upgrade_power(id).to_i}%"
      
      
      
      end
      #if @item.note.split(",")[2].to_i > 0
       # @description += "New MP Cost: #{@item.get_upgrade_reduction(id)}"
      #elsif @item.get_upgrade_power(id) > 0
      #  @description += "Total Power Increase: #{(@item.get_upgrade_power(id) * 100).to_i}%"
      #end
    end
    return @description
  end
  
  def id 
    return @item.id
  end
end

class Skill_Learn_Help
  
  def initialize(item)
    @item = item
    @description = ""
  end
  
  def description
    unless @item == nil
      @item.description
    end
  end
  
  def id 
    return @item.id
  end
end

class Stat_Upgrade_Help
  
  def initialize(index)
    @index = index
    @description = ""
  end
  
  def description
    case @index
    
      when 0
        @description = "Total hit points. +2 per upgrade."
    
      when 1
        @description = "Total magic points. +2 per upgrade."
    
      when 2
        @description = "Attack increases physical damage. +1 per upgrade."
    
      when 3
        @description = "Defense reduces physical damage. +1 per upgrade."
    
      when 4
        @description = "Magic Attack increases magical damage and healing.\n+1 per upgrade."
    
      when 5
        @description = "Magic defense reduces magical damage. +1 per \nupgrade."
    
      when 6
        @description = "Agility allows you to attack sooner, and increases\nthe damage of some special attacks. +1 per upgrade."
      when 7
        @description = "Stealth reduces your random encounter rate. +3 per \nupgrade."
    
      else
        return nil
    end
  end
  
  def id 
    return @item.id
  end
end

class Crystal_Currency_Window < Window_Base
  attr_reader :crystals
  attr_reader :level
  attr_reader :current
  attr_reader :crystal_upgrades
  
  def initialize
    super(0, 166, 186, 251)
    refresh
  end
  
  def window_width
    return 186
  end
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      #draw_item_name(item, rect.x, rect.y)   this is the icon error
      #draw_item_number(rect, item)
      #draw_item_name(item,0,0)
      @data.each_with_index do |skill,index| 
      draw_item_name($data_skills[skill], index, rect.x, line_height * index, line_height, contents.width)
      #took out line_height * index, contents.width and replaced with item_height and item_width     
      end
      make_font_bigger
      end
  end

  def refresh
    contents.clear
    draw_actor_face($game_party.menu_actor,30,8)
    @current = $game_party.menu_actor.id
    @level = $game_party.menu_actor.level
    @crystal_upgrades = $game_party.menu_actor.crystal_upgrades[0]
    @crystals = $game_party.menu_actor.crystals[0]
    make_font_smaller
    
    case @current
      when 1
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Soul: " + "#{spent}/" + "#{total}")
      when 2
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Soul: " + "#{spent}/" + "#{total}")
      when 3
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Soul: " + "#{spent}/" + "#{total}")
      when 4
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Soul: " + "#{spent}/" + "#{total}")
    end
    draw_icon(574, 0, 134, true)
    draw_text(26,135,171, line_height, "Crystals: " + "#{$game_party.item_number($data_items[100])}") 
    
    make_font_bigger
end

def open
    refresh
    super
  end
end

class Crystal_Only_Window < Window_Base
  attr_reader :crystals
  attr_reader :level
  attr_reader :current
  
  def initialize
    super(0, 166, 186, 251)
    refresh
  end
  
  def window_width
    return 186
  end
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      #draw_item_name(item, rect.x, rect.y)   this is the icon error
      #draw_item_number(rect, item)
      #draw_item_name(item,0,0)
      @data.each_with_index do |skill,index| 
      draw_item_name($data_skills[skill], index, rect.x, line_height * index, line_height, contents.width)
      #took out line_height * index, contents.width and replaced with item_height and item_width     
      end
      make_font_bigger
      end
  end

  def refresh
    contents.clear
    draw_actor_face($game_party.menu_actor,30,8)
    @current = $game_party.menu_actor.id
    @level = $game_party.menu_actor.level
    @crystals = $game_party.menu_actor.crystals[0]
    make_font_smaller
    
    draw_icon(558, 0, 109, true)
    draw_text(26,110,171, line_height, "Crystals: " + "#{$game_party.item_number($data_items[101])}") 
    
    make_font_bigger
  end

def open
    refresh
    super
  end
end

class Crystal_Body_Window < Window_Base
  attr_reader :crystals
  attr_reader :level
  attr_reader :current
  attr_reader :crystal_upgrades
  
  def initialize
    super(0, 166, 186, 251)
    refresh
  end
  
  def window_width
    return 186
  end
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      #draw_item_name(item, rect.x, rect.y)   this is the icon error
      #draw_item_number(rect, item)
      #draw_item_name(item,0,0)
      @data.each_with_index do |skill,index| 
      draw_item_name($data_skills[skill], index, rect.x, line_height * index, line_height, contents.width)
      #took out line_height * index, contents.width and replaced with item_height and item_width     
      end
      make_font_bigger
      end
  end

  def refresh
    contents.clear
    draw_actor_face($game_party.menu_actor,30,8)
    @current = $game_party.menu_actor.id
    @level = $game_party.menu_actor.level
    @crystal_upgrades = $game_party.menu_actor.crystal_upgrades[1]
    @crystals = $game_party.menu_actor.crystals[1]
    make_font_smaller
    
    case @current
      when 1
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Body: " + "#{spent}/" + "#{total}")
      when 2
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Body: " + "#{spent}/" + "#{total}")
      when 3
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Body: " + "#{spent}/" + "#{total}")
      when 4
        spent = @crystals
        total = (@level - 1) * 10 + @crystal_upgrades
        draw_text(26,110,171, line_height, "Body: " + "#{spent}/" + "#{total}")
    end
    draw_icon(830, 0, 134, true)
    draw_text(26,135,171, line_height, "Crystals: " + "#{$game_party.item_number($data_items[102])}") 
    
    make_font_bigger
end

def open
    refresh
    super
  end
end


class Class_Upgrade_Window < Window_Command  #parent window
  def initialize(x, y)
    clear_command_list
    make_command_list
    item_max
    super(x, y)
    refresh
    select(0)
    activate
  end
  
  def update_help
    @help_window.set_item(item)
  end
  
  def item
    vocab_item = Class_Upgrade_Help.new(index)
    return vocab_item
  end
  def window_width
    return 186
    end
    
  def item_max
    @list.size
  end
  
  def refresh
    for index in 0...@list.size
    drawing(index)
  end
  end
  
  def drawing(index)
    draw_text(item_rect_for_text(index), command_name(index))
  end

  def clear_command_list
  @list = []
  end

  def make_command_list
    add_command("Upgrade Skills", :upgrade)
    add_command("Learn Skills", :learn)
    add_command("Increase Stats", :stats)
  end
end

class Skill_Upgrade_Window < Window_Selectable
  def initialize(*args) #only accept catg and spell
    super(*args)  #just set these as specific values
    self.active = false
    self.visible = false
    clear_item_list
    item_max
    refresh #may need to select(0), or do as part of scene
  end

  def refresh
    make_item_list
    create_contents
    draw_item(0)
  end
  
  def spacing
    return 0
    end
    
  def update_help
    @help_window.set_item(item)
  end
  
  def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
   # select_last 
  end
  
  #def select_last
   # select_symbol(@@last_command_symbol)
  #end
  
  def col_max
    return 2
  end
  
  def item_max
    @data ? @data.size : 1
  end
  
  def process_ok
    if current_item_enabled?
      Input.update
      deactivate
      call_ok_handler
    else
      Sound.play_buzzer
    end
  end

  def make_item_list
    return unless @actor
    temp_data = []
    @actor.permanent_skills.uniq!
    
    @actor.permanent_skills.each do |id|
      temp_data.push(id) unless id == 480 || id > 699 || id.between?(691,697)
    end
    
    @actor.class.learnings.each do |skill|
      unless @actor.permanent_skills.include?(skill.skill_id) || @actor.class_lvl[@actor.class.id] < skill.level
        temp_data.push(skill.skill_id) unless skill.skill_id == 480 || skill.skill_id > 699 || skill.skill_id.between?(691,697)
      end
    end
    
    @data = temp_data
  end
  
  def item
    unless @data == []
      Skill_Upgrade_Help.new(@data && index >= 0 ? $data_skills[@data[index]] : nil)
    end
  end
  
  def clear_item_list
    @data = []
  end
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      #draw_item_name(item, rect.x, rect.y)   this is the icon error
      #draw_item_number(rect, item)
      #draw_item_name(item,0,0)
      @data.each_with_index do |skill,index| 
      draw_item_name($data_skills[skill], index, rect.x, line_height * index, line_height, contents.width)
      
#took out line_height * index, contents.width and replaced with item_height and item_width     
      end
      make_font_bigger
      end
  end
  
  def draw_item_name(item, index, x, y, height, width, enabled = true)
    return unless item
    skill = item.name
    icon = item.icon_index
    if index % 2 == 0
      change_color(normal_color, enabled)
      if @actor.permanent_skills.include?(item.id)
        change_color(mp_gauge_color2, enabled)
      end
      make_font_smaller
      make_font_smaller
      draw_text(31, y/2, width, line_height, skill)
      draw_icon(icon, 2, y/2, enabled = true)
      make_font_bigger
      make_font_bigger
    
    elsif index % 2 != 0
      change_color(normal_color, enabled)
      if @actor.permanent_skills.include?(item.id)
        change_color(mp_gauge_color2, enabled)
      end
      make_font_smaller
      make_font_smaller
      draw_text(198, y/2 - 12, width, line_height, skill)
      draw_icon(icon, 170, y/2 - 12, enabled = true)
      make_font_bigger
      make_font_bigger
    end
  end
end

class Skill_Learn_Window < Window_Selectable
  def initialize(*args)
    super(*args)
    self.active = false
    self.visible = false
    clear_item_list
    item_max
    refresh
  end

  def refresh
    make_item_list
    create_contents
    draw_item(0)
  end
  
  def spacing
    return 0
  end
    
  def update_help
    @help_window.set_item(item)
  end
  
  def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
   # select_last  end
  
  #def select_last
   # select_symbol(@@last_command_symbol)
  #end
  
  def col_max
    return 2
  end
  
  def item_max
    @data ? @data.size : 1
  end
  
  def process_ok
    if current_item_enabled?
      Input.update
      deactivate
      call_ok_handler
    else
      Sound.play_buzzer
    end
  end
  
  def make_item_list
    return unless @actor
    temp_data = []
    @actor.permanent_skills.uniq!
    
    #@actor.class.learnings.each do |skill|
    #  if 
    #    skill.level < @actor.class_lvl[@actor.class.id]
    #    msgbox skill.level
    #    msgbox @actor.class_lvl[@actor.class.id]
    #  end
    #end
    
    @actor.permanent_skills.each do |id|
      temp_data.push(id) unless id > 697
    end
    
    @actor.class.learnings.each do |skill|
      if @actor.class_lvl[@actor.class.id] >= skill.level
        temp_data.push(skill.skill_id) unless @actor.permanent_skills.include?(skill.skill_id) || skill.skill_id > 697
        if skill.skill_id >= 708 && skill.skill_id <= 710; temp_data.push(skill.skill_id); end #bandaid
      end
    end
    
    $data_classes.each do |classA|
      unless classA == nil || classA == @actor.class
        class_id = classA.id
        classA.learnings.each do |skill|
          if @actor.class_lvl[class_id] > skill.level 
            unless @actor.permanent_skills.include?(skill.skill_id)
              temp_data.push(skill.skill_id)
            end
          end
        end
      end
    end 
    @data = temp_data
  end
  
  def item
    unless @data == []
      Skill_Learn_Help.new(@data && index >= 0 ? $data_skills[@data[index]] : nil)
    end
  end
  
  def clear_item_list
    @data = []
  end
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      #draw_item_name(item, rect.x, rect.y)   this is the icon error
      #draw_item_number(rect, item)
      #draw_item_name(item,0,0)
      @data.each_with_index do |skill,index| 
        draw_item_name($data_skills[skill], index, rect.x, line_height * index, line_height, contents.width)
        #took out line_height * index, contents.width and replaced with item_height and item_width     
      end
      make_font_bigger
    end
  end
  
  def draw_item_name(item, index, x, y, height, width, enabled = true)
    return unless item
    skill = item.name
    icon = item.icon_index
    if index % 2 == 0
      change_color(normal_color, enabled)
      if @actor.permanent_skills.include?(item.id)
        change_color(mp_gauge_color2, enabled)
      end
      make_font_smaller
      make_font_smaller
      draw_text(31, y/2, width, line_height, skill)
      draw_icon(icon, 2, y/2, enabled = true)
      make_font_bigger
      make_font_bigger
    
    elsif index % 2 != 0
      change_color(normal_color, enabled)
      if @actor.permanent_skills.include?(item.id)
        change_color(mp_gauge_color2, enabled)
      end
      make_font_smaller
      make_font_smaller
      draw_text(198, y/2 - 12, width, line_height, skill)
      draw_icon(icon, 170, y/2 - 12, enabled = true)
      make_font_bigger
      make_font_bigger
    end
  end
end

class Passive_Upgrade_Window < Window_Selectable
  def initialize(*args)
    super(*args)
    self.active = false
    self.visible = false
    @actor = $game_party.menu_actor
    clear_item_list
    item_max
    refresh
  end

  def refresh
    make_item_list
    create_contents
    draw_item(0)
  end
  
  def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
   # select_last       
  end
  
  #def select_last
   # select_symbol(@@last_command_symbol)
  #end
  
  def spacing
    return 0
    end
  
  def col_max
    return 2
  end
  
  def item_max
    @data ? @data.size : 1
  end
  
  def process_ok
    if current_item_enabled?
      Input.update
      deactivate
      call_ok_handler
    else
      Sound.play_buzzer
    end
  end

  def make_item_list
    return unless @actor
    @data = [0,0,0,0,0,0,0,0]
    
    8.times do |i|
      @data[i] += @actor.param_base(i)
      @data[i] += @actor.param_passive[i]
    end
    
    
    #TO REMOVE ADDITIONAL STATS:
    #1: @feature_values size equal to final array size
    #2: decrement everything in the case statements by number of stats being removed
    #3: decrement the .times methods by the right amount and increment their i+
    #value towards the end of the method by the same number
    #4: decrement the final .to_i methods by 1
    #5: shift verbiage by the number of stats removed so they align again. 
    
    #@feature_values = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,100,100,100,100,100,100,100,100,100,100]
    #8.times do |i|
      #@feature_values[i] += @actor.param_plus(i)
    #end
    
  end
  
  def update_help
    @help_window.set_item(item)
    end
  
  def item
    passives_item = Stat_Upgrade_Help.new(index)
    return passives_item
  end
  
  def clear_item_list
    @data = []
  end
  
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      #draw_item_name(item, rect.x, rect.y)   this is the icon error
      #draw_item_number(rect, item)
      #draw_item_name(item,0,0)
      make_font_smaller
      for index in 0..@data.size - 1
      draw_item_name(@data[index], index,rect.x, line_height * index, line_height, contents.width)
#took out line_height * index, contents.width and replaced with item_height and item_width     
      end
      make_font_bigger
      end
  end
  
  def draw_item_name(item, index, x, y, height, width, enabled = true)
    return unless item
    param_value = item
    if index % 2 == 0
      param_name = Vocab_Module::PARAMS[index]
      change_color(text_color(13), enabled)
      draw_text(4, y/2, width, line_height, param_name)
      change_color(normal_color, enabled)
      draw_text(120, y/2, width, line_height, "#{param_value}")
    
    #.round(DECIMAL PRECISION) is a good way to display floats with a specific precision 
    #sprintf("%3.2f", param_value) is a good substitute for .round(2)
    
  elsif index % 2 != 0
    param_name = Vocab_Module::PARAMS[index]
    change_color(text_color(13), enabled)
    draw_text(173, y/2 - 12, width, line_height, param_name)
    change_color(normal_color, enabled)
    draw_text(291, y/2 - 12, width, line_height, "#{param_value}")
    end
  end
end

class Scene_Upgrade < Scene_Base
  
  def start
    super
    create_help_window
    create_category_window
    create_skill_window
    create_learn_window
    create_passive_window
    create_currency_window
    create_crystal_window
    create_body_window
    create_message_window
    @actor = $game_party.menu_actor
  end

  def update
    super
    case @category_selector.current_symbol
    
    when :upgrade
    @skill_window.visible = true
    @skill_learn_window.visible = false
    @passive_upgrade_window.visible = false
    @crystal_currency_window.visible = true
    @crystal_only_window.visible = false
    @crystal_body_window.visible = false
    
    when :learn
    @skill_learn_window.visible = true
    @skill_window.visible = false
    @passive_upgrade_window.visible = false
    @crystal_only_window.visible = true
    @crystal_currency_window.visible = false
    @crystal_body_window.visible = false
    
    when :stats
    @passive_upgrade_window.visible = true
    @skill_window.visible = false
    @skill_learn_window.visible = false
    @crystal_currency_window.visible = false
    @crystal_only_window.visible = false
    @crystal_body_window.visible = true
    #super
    end
  end
  
  def create_help_window
    @help_window = Window_Help.new
  end
  
  def create_currency_window
    @crystal_currency_window = Crystal_Currency_Window.new
  end
  
  def create_crystal_window
    @crystal_only_window = Crystal_Only_Window.new
    @crystal_only_window.visible = false
  end
  
  def create_body_window
    @crystal_body_window = Crystal_Body_Window.new
    @crystal_body_window.visible = false
  end
  
  def return_command
    @category_selector.update_help
    @skill_learn_window.unselect
    @skill_window.unselect
    @passive_upgrade_window.unselect
    @skill_learn_window.active = false
    @skill_window.active = false
    @passive_upgrade_window.active = false
    @category_selector.activate
  end
  
  def create_message_window
    @upgrade_message = Upgrade_Message.new(122,160,300,100)
    @upgrade_message.set_handler(:ok,     method(:kill_message))
    @upgrade_message.set_handler(:cancel, method(:kill_message))
    @upgrade_message.hide
    @upgrade_message.viewport = @viewport
  end
  
  def create_category_window
    @category_selector = Class_Upgrade_Window.new(0,71)
    @category_selector.viewport = @viewport
    @category_selector.help_window = @help_window
    @category_selector.set_handler(:cancel, method(:return_scene))
    @category_selector.set_handler(:learn, method(:class_select))
    @category_selector.set_handler(:upgrade, method(:skill_select))
    @category_selector.set_handler(:stats, method(:passive_select))
    @category_selector.set_handler(:cancel, method(:return_scene))
  end
  
  def create_skill_window
    @skill_window = Skill_Upgrade_Window.new(186, 71, 359, 346)
    @skill_window.viewport = @viewport
    @skill_window.help_window = @help_window
    @skill_window.actor = $game_party.menu_actor
    #@category_selector.info_display = @skill_window
    @skill_window.set_handler(:cancel, method(:return_command))
    #THE LINE BELOW IS A PROTOTYPE FOR UPGRADING SKILLS
    @skill_window.set_handler(:ok, method(:process_upgrade))
  end
  
  def create_learn_window
    @skill_learn_window = Skill_Learn_Window.new(186, 71, 359, 346)
    @skill_learn_window.viewport = @viewport
    @skill_learn_window.help_window = @help_window
    @skill_learn_window.actor = $game_party.menu_actor
    #@category_selector.info_display = @skill_window
    @skill_learn_window.set_handler(:cancel, method(:return_command))
    @skill_learn_window.set_handler(:ok, method(:process_learn))
  end
  
  def create_passive_window
    @passive_upgrade_window = Passive_Upgrade_Window.new(186,71,359,346)
    @passive_upgrade_window.help_window = @help_window
    @passive_upgrade_window.actor = $game_party.menu_actor
    @passive_upgrade_window.viewport = @viewport
    @passive_upgrade_window.set_handler(:cancel, method(:return_command))
    @passive_upgrade_window.set_handler(:ok, method(:process_stat))
  end

  def class_select
    @category_selector.active = false
    @skill_learn_window.visible = true
    @skill_learn_window.active = true
    @skill_learn_window.select(0)
  end
  
  def skill_select
    @category_selector.active = false
    @skill_window.visible = true
    @skill_window.active = true
    @skill_window.select(0)
  end


   def process_upgrade
     window = @crystal_currency_window
     spent = window.crystals
     total = (window.level - 1) * 10 + window.crystal_upgrades
     skill = $data_skills[@skill_window.item.id]
     cost = skill.upgrade_cost(@actor.id)
     crystals = $game_party.item_number($data_items[100])
    unless @skill_window.item == nil
      if crystals >= cost && (total - spent >= cost)
        Sound.play_ok
        upgrade_skill(skill)
        @upgrade_message.get_item(skill, "upgrade")
        @upgrade_message.activate
        @help_window.refresh
      else
        RPG::SE.new("Buzzer1", 400, 100).play
        @skill_window.activate
      end
    end
  end

  def upgrade_skill(skill)
    skill.upgrade(@actor.id)
  end

  def process_learn
    smith = [708,709,710]
    return unless @skill_learn_window.item
    skill = $data_skills[@skill_learn_window.item.id]
    cost = skill.learn_cost
    crystals = $game_party.item_number($data_items[101])
    skill_class = get_skill_class(skill.id)
    yes = false
    skill_class.each do |classA|
      if @actor.class_lvl[classA] >= skill.learn_level; yes = true; end
    end
    unless yes == true
      RPG::SE.new("Buzzer1", 400, 100).play
      @skill_learn_window.activate
      return
    end
    if (smith).include?(skill.id) && !@actor.permanent_skills.include?(480)
      RPG::SE.new("Buzzer1", 400, 100).play
      @upgrade_message.show
      @upgrade_message.activate
      @upgrade_message.display_smith_error
      return
    end
    if !@actor.permanent_skills.include?(skill.id) && crystals >= cost
      Sound.play_ok
      learn_skill(skill)
      @skill_window.refresh
      @skill_learn_window.refresh
      @upgrade_message.get_item(skill, "learn")
      @upgrade_message.activate
      @help_window.refresh
    else
      RPG::SE.new("Buzzer1", 400, 100).play
      @skill_learn_window.activate
    end
  end
  
  def learn_skill(skill)
    @actor.permanent_skills.push(skill.id)
     $game_party.lose_item($data_items[101], skill.learn_cost)
     if skill.id == 480; learn_magicsmithing
     elsif skill.id.between?(694,697); learn_wield(skill.id)
     elsif skill.id.between?(691,693); learn_armor(skill.id)
      end
  end
  
  def process_stat
    return unless @passive_upgrade_window.item
    index = @passive_upgrade_window.index
    window = @crystal_body_window
    spent = window.crystals
    total = (window.level - 1) * 10 + window.crystal_upgrades
    crystals = $game_party.item_number($data_items[102])
    cost = 10
    unless @passive_upgrade_window.item == nil
      if crystals >= cost && (total - spent > cost)
        Sound.play_ok
        stat = Stat.new(index)
        stat.upgrade(@actor)
        @upgrade_message.get_item(stat, "stat")
        @upgrade_message.activate
        @help_window.refresh
      else
        RPG::SE.new("Buzzer1", 400, 100).play
        @passive_upgrade_window.activate
      end
    end
  end
  
  #def upgrade_passive(stat)
    
   # @actor.param_passive[stat.index] += stat.increment_value
    #$game_variables[62] -= stat.cost
    #@actor
  #end
  
  def learn_magicsmithing
    smithing_skills = [[698,699],(700..704).to_a, [707], (716..732).to_a, (800..818).to_a, (825..843).to_a]
    smithing_skills.each do |skillset|
      skillset.each do |skill|
        @actor.permanent_skills.push(skill)
      end
    end
  end
  
  def learn_wield(id)
    case id
    when 694
      learn_wield = Upgrade_Wield.new(@actor,3)
    when 695
      learn_wield = Upgrade_Wield.new(@actor,2)
    when 696
      learn_wield = Upgrade_Wield.new(@actor,0)
    when 697
      learn_wield = Upgrade_Wield.new(@actor,1)
    end
  end
  
  def learn_armor(id)
    case id
    when 691
      new_feature = RPG::BaseItem::Feature.new(code = 52,data_id = 7,value = 0.0)
      @actor.added_feats.features.push(new_feature)
    when 692
      new_feature = RPG::BaseItem::Feature.new(code = 52,data_id = 4,value = 0.0)
      @actor.added_feats.features.push(new_feature)
    when 693
      new_feature = RPG::BaseItem::Feature.new(code = 52,data_id = 5,value = 0.0)
      @actor.added_feats.features.push(new_feature)
    end
  end

  def passive_select
    @category_selector.active = false
    @passive_upgrade_window.visible = true
    @passive_upgrade_window.active = true
    @passive_upgrade_window.select(0)
  end
  
  def kill_message
    case @upgrade_message.context
      when "upgrade"
        @category_selector.active = false
        @skill_window.visible = true
        @skill_window.active = true
        @crystal_currency_window.refresh
        @crystal_only_window.refresh
        @skill_window.refresh
      when "learn"
        @category_selector.active = false
        @skill_learn_window.visible = true
        @skill_learn_window.active = true
        @crystal_currency_window.refresh
        @crystal_only_window.refresh
        @skill_learn_window.refresh
      when "stat"
        @category_selector.active = false
        @passive_upgrade_window.visible = true
        @passive_upgrade_window.active = true
        @passive_upgrade_window.refresh
        @crystal_body_window.refresh
        @passive_upgrade_window.refresh
    end
    @upgrade_message.hide
    @upgrade_message.deactivate
  end
  
  def get_skill_class(id)
    skill_class = 0
    case id
      when 120..139
        skill_class = [13]
      when 140..159
        skill_class = [8]
      when 160..179
        skill_class = [7]
      when 180..199
        skill_class = [9]
      when 200..219
        skill_class = [12]
      when 220..239
        skill_class = [1]
      when 240..259
        skill_class = [2]
      when 260..279
        skill_class = [10]
      when 280..299
        skill_class = [3]
      when 300..319
        skill_class = [11]
      when 320..339
        skill_class = [6]
      when 340..379
        skill_class = [4]
      when 380..400
        skill_class = [14]
      when 400..419
        skill_class = [15]
      when 691
        skill_class = [5,9,10,12,13]
      when 692
        skill_class = [5,9,10,12,13]
      when 693
        skill_class = [9,10,12,13]
      when 694
        skill_class = [8,14,15]
      when 695
        skill_class = [10]
      when 696
        skill_class = [5,7,9,12,13]
      when 697
        skill_class = [6,11]
      when 460..1000
        skill_class = 5
    return skill_class
    end
  end
  
end