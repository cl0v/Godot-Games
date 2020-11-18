extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 31400
const MAX_PLAYERS = 5

var players = {}
var self_data = {name = "", position = Vector2(360,180)}

func create_server(player_name):
	self_data.name = player_name
	players[1] = self_data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer

func connect_to_server(player_name):
	self_data.name = player_name
	var err = get_tree().connect("connected_to_server", self, "_connected_to_server")
	if err: print(err)
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().network_peer = peer

func _connected_to_server():
	players[get_tree().get_network_unique_id()] = self_data
	rpc("_send_player_info", get_tree().get_network_unique_id(), self_data)

remote func _send_player_info(id, info):
	if get_tree().is_network_server():
		for peer_id in players:
			rpc_id(id, "_send_player_info", peer_id, players[peer_id])
	players[id] = info 
	
	var new_player = preload("res://scenes/Player.tscn").instance()
	new_player.name = str(id)
	new_player.set_network_master(id)
	get_tree().root.add_child(new_player)
	new_player.init(info.name, info.position, true)
