extends Area2D


@onready var los = get_node("Enemy_wall_vision") 
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var enemy = get_parent()




func _ready():
	los.enabled = true

func _process(delta):
	if player:
		#var direction_to_player = (player.position - enemy.position).normalized()
		los.target_position = to_local(player.position - Vector2(0,-5)) # 
		#print("Direction to Player: ", direction_to_player)
		los.enabled = true

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if los.is_colliding():
			var collider = los.get_collider()
			if collider.name == "Player":
				enemy.set_can_move(false)
				$"../Bottom Cloud".visible = true
				$"../Bottom Cloud/Top Cloud".visible = true
				$"../Bottom Cloud".play('Cloud')
				$"../Bottom Cloud/Top Cloud".play('Cloud')


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		enemy.set_can_move(true)
		$"../Bottom Cloud".stop()
		$"../Bottom Cloud/Top Cloud".stop()
		$"../Bottom Cloud".visible = false
		$"../Bottom Cloud/Top Cloud".visible = false
		
