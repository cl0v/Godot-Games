extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 8080
const MAX_PEERS = 5

var players = []

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")

func create_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(DEFAULT_PORT, MAX_PEERS)
	get_tree().network_peer = host
	players.append(get_tree().get_network_unique_id())

func create_client():
	var client = NetworkedMultiplayerENet.new()
	client.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().network_peer = client
	players.append(get_tree().get_network_unique_id())

func cancel_request():
	var host = NetworkedMultiplayerENet.new()
	host.close_connection()

func _on_network_peer_connected(id):
	rpc_id(id, "register_player")

remote func register_player():
	players.append(get_tree().get_rpc_sender_id())

#
#func begin_game():
#	PlayerNetwork.rpc("build_world", players)
