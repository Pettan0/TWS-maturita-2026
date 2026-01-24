extends CharacterBody3D

@onready var player: CharacterBody3D = $"../Player"
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

const SPEED = 5.0

func _physics_process(delta: float):
	velocity = Vector3.ZERO
	nav_agent.set_target_position(player.global_position)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_position).normalized() * SPEED
	
	move_and_slide()
