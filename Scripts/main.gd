extends Control

@onready var board = $Board

const CARD = preload("res://Scenes/card.tscn");

var board_state := [];

func _ready():
	create_board();


func _process(_delta):
	if board.get_child_count() == 0:
		create_board();


func create_board():
	randomize();
	var init_board := [];
	
	for pos in range(1, 7):
		init_board.push_back([pos, init_board.size()]);
		init_board.push_back([pos, init_board.size()]);
	
	init_board.shuffle();
	
	var items = [];
	var mem = [];
	
	for item in init_board:
		mem.push_back(item);
		if mem.size() == 4:
			items.push_back(mem);
			mem = [];
	
	for row in range(3):
		for col in range(4):
			var card = CARD.instantiate();
			var number = items[row][col][0];
			var id = items[row][col][1];

			var node2d = Node2D.new();
			node2d.add_child(card);
			var posX = col * (card.get_rect().size.x + 52);
			var posY = row * (card.get_rect().size.y + 9);
			node2d.position = Vector2(posX, posY);
			
			self.board.add_child(node2d);
			card.change_card_number(number);
			card.ID = id;
			board_state.push_back(card);
