extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

export var FRICTION = 200
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var MINIMAL_WANDER_RANGE = 2.5


enum {
	IDLE,
	WANDER,
	CHASE
}
var state = IDLE

onready var sprite = $AniSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtboxes
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	state = pick_random_state([IDLE,WANDER])
	animationTree.active = true
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			animationState.travel("idle")
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= MINIMAL_WANDER_RANGE:
				update_wander()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				 accelerate_towards_point(player.global_position, delta)
			else:
				accelerate_towards_point(wanderController.target_position, delta)
				if global_position.distance_to(wanderController.target_position) <= MINIMAL_WANDER_RANGE:
					update_wander()

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() *delta * 400
	velocity = move_and_slide(velocity)

func update_wander():
	state = pick_random_state([IDLE,WANDER])
	wanderController.start_wander_timer(rand_range(1,3))

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	animationTree.set("parameters/run/blend_position", direction)
	animationState.travel("run")

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtboxes_area_entered(area):
	stats.health -= area.damage + PlayerStats.bonus_damage
	knockback = area.knockback_vector * 115
	hurtbox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
