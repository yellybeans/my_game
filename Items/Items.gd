extends Resource
class_name Item

var stats = PlayerStats

export(String) var name = ""
export(Texture) var texture

enum ItemType { GENERIC, CONSUMABLE, QUEST, EQUIPMENT}
export(ItemType) var Itemtype

export(int) var damage_bonus = 0
export(int) var health_bonus = 0
export(int) var heal_power = 0



func apply_bonus():#
	if Itemtype == 3:
		stats.max_health += health_bonus
		stats.health += health_bonus
		stats.bonus_damage += damage_bonus

func remove_bonus():#
	if Itemtype == 3:
		stats.health -= health_bonus
		stats.max_health -= health_bonus
		stats.bonus_damage -= damage_bonus
		

func use_item():
	if Itemtype == 2:
		stats.health += heal_power
	
	
