# ERROR : https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-error


extends Node


const UserLabel = preload("res://user_label.tscn")

@onready var Menu = $Menu
@onready var Log = $Log
@onready var Console = $Log/HBoxContainer/Console
@onready var PortLineEdit = $Menu/GridContainer/PortLineEdit
@onready var IpLineEdit = $Menu/GridContainer/IpLineEdit

# A MultiplayerPeer implementation that should be passed to
# MultiplayerAPI.multiplayer_peer after being initialized as either a client,
# server, or mesh. Events can then be handled by connecting to MultiplayerAPI
# signals. See ENetConnection for more information on the ENet library wrapper.

# Note: ENet only uses UDP, not TCP. When forwarding the server port to make
# your server accessible on the public Internet, you only need to forward the
# server port in UDP. You can use the UPNP class to try to forward the server
# port automatically when starting the server.


func _ready():
	Log.hide()

func cout(line):
	print(line)
	Console.text = line + "\n" + Console.text

func add_user(peer_id):
	cout("Adding player " + str(peer_id))
	var user_label = UserLabel.instantiate()
	user_label.name = str(peer_id)
	$Log/HBoxContainer/ScrollContainer/VBoxContainer.add_child(user_label, true)

func drop_user(peer_id):
	if $Log/HBoxContainer/ScrollContainer/VBoxContainer.has_node(str(peer_id)):
		$Log/HBoxContainer/ScrollContainer/VBoxContainer.remove_child($Log/HBoxContainer/ScrollContainer/VBoxContainer.get_node(str(peer_id)))
	

func _on_host_button_pressed():
	Menu.hide()
	Log.show()
	# establish_server(int(PortLineEdit.text))
	$Network.establish_server()
	cout("Starting server..." + IpLineEdit.text + ":" + PortLineEdit.text)
	add_user(multiplayer.get_unique_id())


func _on_join_button_pressed():
	Menu.hide()
	Log.show()
	# establish_client(IpLineEdit.text, int(PortLineEdit.text))
	$Network.establish_client()


func _on_network_connected_to_server():
	cout("Connected to server!")


func _on_network_connection_failed():
	cout("Failed to connect.")


func _on_network_peer_connected(peer_id):
	cout("Peer connected : " + str(peer_id))
	add_user(peer_id)


func _on_network_peer_disconnected(peer_id):
	cout("Peer disconnected : " + str(peer_id))
	drop_user(peer_id)


func _on_network_server_disconnected():
	cout("Server disconnected")
