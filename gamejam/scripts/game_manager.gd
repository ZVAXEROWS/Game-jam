extends Node

var score = 0
@onready var score_lable: Label = $ScoreLable

func add_point():
	score += 1 
	score_lable.text = "you Collected:  " + str(score) + "  Coins."
