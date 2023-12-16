extends Node2D

@export var heart1 : Texture2D
@export var heart0 : Texture2D

@onready var heart_1 = $heart1
@onready var heart_2 = $heart2
@onready var heart_3 = $heart3

func _ready():
	HealthManager.on_health_changed.connect(on_player_health_changed)
	
func on_player_health_changed(currentHP : int):
	if currentHP == 3:
		heart_3.texture == heart1
	elif currentHP < 3:
		heart_3.texture == heart0
		
	if currentHP == 2:
		heart_2.texture == heart1
	elif currentHP < 2:
		heart_2.texture == heart0
		
	if currentHP == 1:
		heart_1.texture == heart1
	elif currentHP < 1:
		heart_1.texture == heart0
	
