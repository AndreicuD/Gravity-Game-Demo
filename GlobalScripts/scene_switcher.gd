extends Node

var current_level
var is_loading_level : bool = false

var next_level = null
var next_level_name : String

func _ready():
	current_level = get_tree().get_first_node_in_group("Level")

func change_level(wanted_level_name : String):
	if is_loading_level:
		return
	is_loading_level=true

	next_level = load("res://Levels/" + wanted_level_name + ".tscn").instantiate()
	Global.play_transition("Fade_In")

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Fade_In":
			Global.reset_player_position_and_health()
			current_level.queue_free()
			current_level=next_level
			add_child(current_level)
			Global.play_transition("Fade_Out")
		"Fade_Out":
			is_loading_level=false
			Global.set_spawn_point(Global.default_spawn_point, Global.default_spawn_point_gravity)
			next_level=null
