extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.add_point()
		print("+1 coin")
		animation_player.play("pickUP")
