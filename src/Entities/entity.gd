class_name Entity
extends Sprite2D

enum AIType {NONE, HOSTILE}
enum EntityType {CORPSE, ITEM, ACTOR}

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = Grid.grid_to_world(grid_position)

var type: EntityType:
	set(value):
		type = value
		z_index = type

var _definition: EntityDefinition
var entity_name: String
var blocks_movement: bool
var map_data: MapData

var fighter_component: FighterComponent
var ai_component: BaseAIComponent

func _init(_map_data: MapData, start_position:Vector2i, entity_definition: EntityDefinition) -> void:
	centered = false
	grid_position = start_position
	map_data = _map_data
	set_entity_type(entity_definition)

func move(move_offset: Vector2i) -> void:
	map_data.unregister_blocking_entity(self)
	grid_position += move_offset
	map_data.register_blocking_entity(self)

func set_entity_type(entity_definition: EntityDefinition) -> void:
	_definition = entity_definition
	type = _definition.type
	blocks_movement = _definition.is_blocking_movement
	entity_name = _definition.name
	texture = entity_definition.texture
	modulate = entity_definition.color

	match entity_definition.ai_type:
		AIType.HOSTILE:
			ai_component = HostileEnemyAIComponent.new()
			add_child(ai_component)

	if entity_definition.fighter_definition:
		fighter_component = FighterComponent.new(entity_definition.fighter_definition)
		add_child(fighter_component)

func is_blocking_movement() -> bool:
	return blocks_movement

func get_entity_name() -> String:
	return entity_name

func is_alive() -> bool:
	return ai_component != null
