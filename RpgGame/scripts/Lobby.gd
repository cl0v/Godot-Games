extends Control

var ConnectionDisplay = {
	none = "",
	connected = "Successfully connected to the server",
	failed = "Failed to connect to the server",
	disconnected = "Server disconnected",
	kicked = "You have been kicked",
	not_server = "Create the server first",
	invalid_name = "Invalid name"
}


onready var host_btn = $Connect/HostBtn
onready var join_btn = $Connect/JoinBtn
onready var start_btn = $StartBtn
onready var ip_txt = $Connect/IpText
onready var name_txt = $Connect/NameText
onready var warning_txt = $Connect/Warning

var player_info = {}

func _ready():
	get_tree().connect("connection_failed", self, "_on_connection_failed")
#	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

func _player_disconnected(id):
	player_info.erase(id)

func _on_connection_failed():
	$HostBtn.disabled = false
	$JoinBtn.disabled = false
	$Warning.text = ConnectionDisplay.failed

#func _on_server_disconnected():
#	$Warning.text = ConnectionDisplay.disconnected
#	# TODO: quando eu dou queue free na lobby, essa func bugga no cliente

func _on_HostBtn_pressed():
	if name_txt.text == "":
		warning_txt.text = ConnectionDisplay.invalid_name
		return
	host_btn.disabled = true
	join_btn.disabled = true
	warning_txt.text = ""
	Network.init_server()

func _on_JoinBtn_pressed():
	if name_txt.text == "":
		warning_txt.text = ConnectionDisplay.invalid_name
		return
	host_btn.disabled = true
	join_btn.disabled = true
	start_btn.disabled = true
	warning_txt.text = ConnectionDisplay.none
	Network.init_client()

func _on_StartBtn_pressed():
	#is_network_server: No network peer is assigned, i cant be a server
	if not get_tree().is_network_server():
		warning_txt.text = ConnectionDisplay.not_server
		return
	Network.begin_game()
	
