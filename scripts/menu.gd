extends Node2D

@onready var game = preload("res://scenes/Game.tscn")


func _on_start_btn_pressed():
	get_tree().change_scene_to_packed(game)
