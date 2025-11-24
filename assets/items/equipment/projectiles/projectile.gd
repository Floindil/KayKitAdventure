extends Item
class_name Projectile

@export_enum(
    StaticNames.projectile_throw,
    StaticNames.projectile_ammunition,
    StaticNames.projectile_magic
)
var peojectile_type: String
@export var speed: int
@export var has_gravity: bool = true
@export var projectile_script: Script

var velocity: Vector3
var hit: bool = false

func shoot(direction: Vector3) -> void:
    velocity = direction.normalized() * speed

func _physics_process(delta: float) -> void:
    if hit:
        return

    if has_gravity:
        velocity.y -= StaticValues.gravity * delta

    var collision = move_and_collide(velocity)

    if collision:
        hit = true
        _on_hit(collision)