extends Area2D


@onready var los = get_node("Enemy_wall_vision") 
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var enemy = get_parent()



# Called when the node enters the scene tree for the first time.
func _ready():
	los.enabled = true #Enable constant line of sight for enemies

func _process(delta):
	if player: #Always point enemy sights as player
		los.target_position = to_local(player.position - Vector2(0,-5)) # 
		los.enabled = true

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": #Detect player if in area and not being other collision
		if los.is_colliding():
			var collider = los.get_collider()
			if collider.name == "Player":
				enemy.set_can_move(false) #Stop enemy movement
				$"../Bottom Cloud".visible = true #Enemy Animations
				$"../Bottom Cloud/Top Cloud".visible = true
				$"../Bottom Cloud".play('Cloud')
				$"../Bottom Cloud/Top Cloud".play('Cloud')


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		enemy.set_can_move(true) #Continue enemy movement
		$"../Bottom Cloud".stop()  #Enemy Animations
		$"../Bottom Cloud/Top Cloud".stop()
		$"../Bottom Cloud".visible = false
		$"../Bottom Cloud/Top Cloud".visible = false
		
