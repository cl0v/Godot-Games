extends Node

signal new_peer_connected
signal failed_to_connect_on_server

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 7777
const MAX_PLAYERS = 5

var players_info = []



func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_network_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

func host_game():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	

func join_game(ip):
	var peer = NetworkedMultiplayerENet.new()
	if ip:
		peer.create_client(ip, DEFAULT_PORT)
	else:
		peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().network_peer = peer
	
remote func register_player(id):
	players_info.append(id)

remotesync func start_game():
	get_tree().root.get_node("Lobby").queue_free()
	var world = Node2D.new()
	get_tree().root.add_child(world)
	
	var my_player = preload("res://scenes/Player.tscn").instance()
	world.add_child(my_player)
	
	for p_id in players_info:
		var player = preload("res://scenes/Player.tscn").instance()
		world.add_child(player)
	

func _on_network_peer_connected(id):
#	emit_signal("new_peer_connected")
	rpc_id(id, "register_player", id)

func _on_network_peer_disconnected(id):
	players_info.erase(id)

func _on_connected_to_server():
	print("Connected to server")

func _on_connection_failed():
	emit_signal("failed_to_connect_on_server")

func _on_server_disconnected():
	print("server_disconnected")
