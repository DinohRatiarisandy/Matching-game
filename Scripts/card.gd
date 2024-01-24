extends ColorRect

@onready var card_number_label = $CardNumberLabel;
@onready var filter = $Filter;
@onready var show_timer = $ShowTimer

var card_number : int;
var ID : int;

func change_card_number(number : int) -> void:
	card_number = number;
	card_number_label.text = str(card_number);


func _on_filter_gui_input(event):
	if CardsSelected.card_selected.size() == 2:
		return;
		
	if event.is_action_pressed("left_click"):
		CardsSelected.card_selected.push_back(self);
		filter.set_color(0);
	
		if CardsSelected.card_selected.size() == 2:
			show_timer.start();

func _on_show_timer_timeout():
	var card1 = CardsSelected.card_selected[0];
	var card2 = CardsSelected.card_selected[1];
	
	if card1.card_number == card2.card_number and card1.ID != card2.ID:
		card1.get_parent().queue_free();
		card2.get_parent().queue_free();
	
	card1.filter.set_color(Color(0, 0, 0, 1));
	card2.filter.set_color(Color(0, 0, 0, 1));
	
	CardsSelected.card_selected = [];
