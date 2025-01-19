extends "res://scripts/base_piece.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id = 6
	pos = Vector2(-1,-1)
	moved = false
	value = -1
	moves = []
	directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)] # implement how far
	
