extends Resource
class_name Item


export(String) var name = ""
export(Texture) var texture

enum ItemType { GENERIC, CONSUMABLE, QUEST, EQUIPMENT}

export(int) var Damage_bonus = 0
export(int) var health_bonus = 0
export(int) var heal_power = 0
