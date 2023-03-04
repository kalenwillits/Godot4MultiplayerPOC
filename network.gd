extends MultiplayerAPI
# A MultiplayerPeer implementation that should be passed to
# MultiplayerAPI.multiplayer_peer after being initialized as either a client,
# server, or mesh. Events can then be handled by connecting to MultiplayerAPI
# signals. See ENetConnection for more information on the ENet library wrapper.

# Note: ENet only uses UDP, not TCP. When forwarding the server port to make
# your server accessible on the public Internet, you only need to forward the
# server port in UDP. You can use the UPNP class to try to forward the server
# port automatically when starting the server.
var peer = ENetMultiplayerPeer.new() 



# Emitted when this MultiplayerAPI's multiplayer_peer fails to establish a
# connection to a server. Only emitted on clients.
# signal peer_connected(peer_id) 

# Emitted when this MultiplayerAPI's multiplayer_peer disconnects from a
# peer. Clients get notified when other clients disconnect from the same
# server.
# signal peer_disconnected(peer_id) 

# Emitted when this MultiplayerAPI's multiplayer_peer successfully
# connected to a server. Only emitted on clients.
# signal connected_to_server 

# Emitted when this MultiplayerAPI's multiplayer_peer fails to establish a
# connection to a server. Only emitted on clients.
# signal connection_failed 
# signal server_disconnected 
# -------------------------------------------------------------------------------------------------------------------- #

func establish_server(address: String = "*", port: int = 5000, max_clients: int = 32):
	# 	Create server that listens to connections via port. The port needs to
	# 	be an available, unused port between 0 and 65535. Note that ports below
	# 	1024 are privileged and may require elevated permissions depending on
	# 	the platform.
	assert(peer.create_server(port, max_clients) == OK)

	# The IP used when creating a server. This is set to the wildcard "*" by
	# default, which binds to all available interface.
	peer.set_bind_ip(address)
	
	# The peer object to handle the RPC system (effectively enabling networking
	# when set). 
	set_multiplayer_peer(peer)

#	assert(peer_connected.connect(_on_peer_connected) == OK)
#	assert(peer_disconnected.connect(_on_peer_disconnected) == OK)
#

func establish_client(address: String = "localhost", port: int = 5000):

	# Create client that connects to a server at address using specified port.
	assert(peer.create_client(address, port) == OK)
	
	# The peer object to handle the RPC system (effectively enabling networking
	# when set). 
	set_multiplayer_peer(peer)
#
#	assert(connected_to_server.connect(_on_connected_to_server) == OK)
#
#	assert(connection_failed.connect(_on_connection_failed) == OK)
#
#	# Emitted when this MultiplayerAPI's multiplayer_peer disconnects from
#	# server. Only emitted on clients.
#	assert(server_disconnected.connect(_on_server_disconnected) == OK)




# func _on_peer_connected(peer_id):
# 	cout("Peer connected : " + str(peer_id))
# 	add_user(peer_id)
	
# func _on_peer_disconnected(peer_id):
# 	cout("Peer disconnected : " + str(peer_id))
# 	drop_user(peer_id)
	
# func _on_connected_to_server():
# 	cout("Connected to server!")

# func _on_connection_failed():
# 	cout("Failed to connect.")
	
# func _on_server_disconnected():
# 	cout("Server disconnected")
