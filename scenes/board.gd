extends Sprite2D

enum RUN_STATE {
	GENERATE = 0,
	PLACEMENT = 1,
	WHITE = 2,
	BLACK = 3,
	SHOP = 4,
	ENDSCREEN = 5,
}

@onready var player = $"../player"
@onready var player_stored_pieces = $"../player/player_pieces/stored_pieces"
@onready var player_deployed_pieces = $"../player/player_pieces/deployed_pieces"
@onready var board_pieces = $board_pieces

#Board Settings
var CELL_WIDTH : int = 18
var BOARD_LEN : int
var BOARD_WID : int

#Game Statistics
var MOVE_COUNT  : int
var START_COLOR : RUN_STATE
var CURR_STATE : RUN_STATE
var CURR_TURN : RUN_STATE

#The Actual Board
var board : Array

func _ready() -> void:
	generate_state()

signal click_signal

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		click_signal.emit()

func generate_state():
	#Randomize Later
	BOARD_LEN = 8
	BOARD_WID = 8 

	MOVE_COUNT = 0 
	
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	board.append([null,null,null,null,null,null,null,null])
	
	#display_board()
	START_COLOR = RUN_STATE.WHITE
	CURR_TURN = START_COLOR
	CURR_STATE = RUN_STATE.GENERATE

func place_state():
	var pieces_to_place = player_stored_pieces.get_children()
	
	#Implement Confirmation
	
	for piece in pieces_to_place:
		await click_signal
		while invalid_placement():
			await click_signal

		#Get mouse position of input
		var var1 = snapped(get_global_mouse_position().x,0) / CELL_WIDTH
		var var2 = abs(snapped(get_global_mouse_position().y,0)) / CELL_WIDTH
		
		board[var2][var1] = piece
		player_stored_pieces.remove_child(piece)
		player_deployed_pieces.add_child(piece)
		board_pieces.add_child(piece)
		
		#display_board

func invalid_placement():
	#Out of Board
	if get_rect().has_point(to_local(get_global_mouse_position())): return false
	
	#Out of Territory
	if abs(snapped(get_global_mouse_position().y,0)) / CELL_WIDTH <= 1: return false
	
	#On Piece 
	
	#In Hazards
	
	
