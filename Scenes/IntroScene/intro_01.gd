extends Node2D

const NPC_001 = preload("uid://c83nq8fbmt1cl") #("res://Scenes/Characters/npc001/npc001.tscn")


func _ready() -> void:
	call_deferred("npc_box_left")
	call_deferred("npc_cart_left")
	call_deferred("npc_bloom_left")
	call_deferred("npc_box_right")
	call_deferred("npc_cart_right")
	call_deferred("npc_bloom_right")
	call_deferred("noble_go_left")
	


func noble_go_left() -> void :
	%Noble/Noble1.get_node("%AnimationPlayer").play("walk1")
	%Noble/Noble2.get_node("%AnimationPlayer").play("walk2")
	
	var tween = get_tree().create_tween()
	tween.tween_property(%Noble/Noble1, "position", Vector2(620, 214), 10.0)
	tween.parallel().tween_property(%Noble/Noble2, "position", Vector2(675, 214), 10.0)
	
	tween.tween_callback(look_down.bind(%Noble/Noble1))
	tween.tween_callback(look_down.bind(%Noble/Noble2)).set_delay(1)


func look_down(path : CharacterBody2D) -> void:
	path.get_node("%AnimationPlayer").play("Look")


func npc_box_left() -> void :
	for npc_box in %NPC_Box_Left.get_children(): # Get_every nodes in %NPC
		npc_box.npc_type = "box"
		npc_box.npc_box(Vector2.LEFT)
		npc_box.connect("exit_screen", spawn_npc_l)


func npc_box_right() -> void :
	for npc_box in %NPC_Box_Right.get_children(): # Get_every nodes in %NPC
		npc_box.npc_type = "box"
		npc_box.npc_box(Vector2.RIGHT)
		npc_box.get_node("%Marker2D").scale.x = -1
		npc_box.connect("exit_screen", spawn_npc_l)


func npc_cart_left() -> void :
	for npc_cart in %NPC_Cart_Left.get_children(): # Get_every nodes in %NPC
		npc_cart.npc_type = "cart"
		npc_cart.npc_cart(Vector2.LEFT)
		npc_cart.connect("exit_screen", spawn_npc_l)


func npc_cart_right() -> void :
	for npc_cart in %NPC_Cart_Right.get_children(): # Get_every nodes in %NPC
		npc_cart.npc_type = "cart"
		npc_cart.npc_cart(Vector2.RIGHT)
		npc_cart.get_node("%Marker2D").scale.x = -1
		npc_cart.connect("exit_screen", spawn_npc_l)


func npc_bloom_left() -> void :
	for npc_bloom in %NPC_Broom_Left.get_children(): # Get_every nodes in %NPC
		npc_bloom.npc_type = "bloom"
		npc_bloom.npc_bloom(Vector2.LEFT)
		npc_bloom.connect("exit_screen", spawn_npc_l)


func npc_bloom_right() -> void :
	for npc_bloom in %NPC_Broom_Right.get_children(): # Get_every nodes in %NPC
		npc_bloom.npc_type = "bloom"
		npc_bloom.npc_bloom(Vector2.RIGHT)
		npc_bloom.get_node("%Marker2D").scale.x = -1
		npc_bloom.connect("exit_screen", spawn_npc_l)


func spawn_npc_l(npc_type, go_direction) -> void :
	if npc_type == "box":
		var box_npc = NPC_001.instantiate()
		if go_direction == Vector2.LEFT:
			box_npc.position = Vector2(2060, 964)
			%NPC_Box_Left.add_child(box_npc)
			box_npc.call_deferred("npc_box", Vector2.LEFT)
		else:
			box_npc.position = Vector2(-142, 964)
			box_npc.get_node("%Marker2D").scale.x = -1
			%NPC_Box_Right.add_child(box_npc)
			box_npc.call_deferred("npc_box", Vector2.RIGHT)
		box_npc.npc_type = "box"
		box_npc.connect("exit_screen", spawn_npc_l)
		print("Spwan Box")
	elif  npc_type == "cart":
		var cart_npc = NPC_001.instantiate()
		if go_direction == Vector2.LEFT:
			cart_npc.position = Vector2(2060, 964)
			%NPC_Cart_Left.add_child(cart_npc)
			cart_npc.call_deferred("npc_cart", Vector2.LEFT)
		else:
			cart_npc.position = Vector2(-142, 964)
			cart_npc.get_node("%Marker2D").scale.x = -1
			%NPC_Cart_Left.add_child(cart_npc)
			cart_npc.call_deferred("npc_cart", Vector2.RIGHT)
		cart_npc.npc_type = "cart"
		cart_npc.connect("exit_screen", spawn_npc_l)
		print("Spwan Cart")
	elif  npc_type == "bloom":
		var bloom_npc = NPC_001.instantiate()
		if go_direction == Vector2.LEFT:
			bloom_npc.position = Vector2(2060, 964)
			%NPC_Broom_Left.add_child(bloom_npc)
			bloom_npc.call_deferred("npc_bloom", Vector2.LEFT)
		else:
			bloom_npc.position = Vector2(-142, 964)
			bloom_npc.get_node("%Marker2D").scale.x = -1
			%NPC_Broom_Left.add_child(bloom_npc)
			bloom_npc.call_deferred("npc_bloom", Vector2.RIGHT)
		bloom_npc.npc_type = "bloom"
		bloom_npc.connect("exit_screen", spawn_npc_l)
		print("Spwan Bloom")
	else: # null
		pass
