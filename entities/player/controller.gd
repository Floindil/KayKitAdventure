extends Node

var current_mapping = null

func _ready() -> void:
	var player: Player = get_node("..")
	player.toggle_menu.connect(_on_toggle_menu)
	
func _on_toggle_menu(in_menu: bool) -> void:
	if in_menu:
		current_mapping = StaticNames.map_menu
	else:
		current_mapping = StaticNames.map_in_game
	
