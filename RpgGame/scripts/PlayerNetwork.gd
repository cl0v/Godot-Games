extends Node

onready var map = load("res://scenes/Game.tscn").instance()
var data = {}

var players = {}

remotesync func build_world(players_id):
	
	var spawn_points = {}
	var spawn_point_idx = 0

	for p_id in players_id:
		if p_id == 1:
			spawn_points[p_id] = 0
			continue
		spawn_point_idx += 1
		spawn_points[p_id] = spawn_point_idx

	get_tree().get_root().get_node("Lobby").hide()
	get_tree().get_root().add_child(map)
	for p_id in spawn_points:
		var spawn_pos = map.get_node("MapSort/SpawnPoints/" + str(spawn_points[p_id])).position
		if p_id == get_tree().get_network_unique_id():
			var player = load("res://scenes/Player.tscn").instance()
			player.set_name(str(p_id))
			player.position = spawn_pos
			map.get_node("MapSort/Players").add_child(player)
			players[p_id] = player
			continue
		var puppet_player = load("res://scenes/PuppetPlayer.tscn").instance()
		puppet_player.set_name(str(p_id))
		puppet_player.position = spawn_pos
		map.get_node("MapSort/Players").add_child(puppet_player)
		players[p_id] = puppet_player

remote func receive_data_from_player(d):
	var id = get_tree().get_rpc_sender_id()
	data[id] = d
	
#Posso melhorar esse processo e emitir um signal, apenas quando os valores trocam, o puppet recebe os valores
func _process(delta):
	#Necessario verificar se existe conexão, pois o codigo ira retornar um erro caso o servidor saia
	set_puppet_data()
	
func set_puppet_data():
	if (data.size() != players.size() -1):
		return
	for id in players:
		if id == get_tree().get_network_unique_id():
			continue
		players[id].position = data[id][0]
		players[id].motion = data[id][1]
		players[id].animation_state = data[id][2]
