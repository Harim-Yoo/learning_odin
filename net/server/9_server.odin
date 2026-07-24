package main

import "core:fmt"
import "core:net"
import "core:thread"

thread_handler :: proc(client_socket: net.TCP_Socket) {

	buffer: [256]u8
	for {

		recv_bytes, recv_err := net.recv_tcp(client_socket, buffer[:])
		if recv_err != nil || recv_bytes == 0 {
			break
		}
		received := buffer[:recv_bytes]
		fmt.printf("This is what I have received: %v", len(received), received)

		bytes_wrtn, sent_err := net.send_tcp(client_socket, received)
		fmt.printf("Echoed back the packets:%v\n", bytes_wrtn)
		if sent_err != nil {
			break
		}
	}
	net.close(client_socket)
}

tcp_echo_server :: proc(ip: string, port: int) {

	addr, ok := net.parse_ip4_address(ip)
	ensure(ok)

	//This is a server side. We must wait for the client by setting up the server part by listening.

	endpoint := net.Endpoint {
		address = addr,
		port    = port,
	}

	socket, err := net.listen_tcp(endpoint)
	ensure(err == nil)

	defer net.close(socket)

	fmt.printf(
		"Listening to the port:%s\n",
		net.endpoint_to_string(endpoint, context.temp_allocator),
	)

	for {

		free_all(context.temp_allocator)

		client_socket, client_endpoint, accept_err := net.accept_tcp(socket)
		if accept_err != nil {
			continue
		}

		fmt.printf("Client's endpoint: %v\n", client_endpoint)
		//prepare buffer size

		thread.run_with_poly_data(client_socket, thread_handler)

	}

	fmt.println("socket closed")
}


main :: proc() {
	tcp_echo_server("127.0.0.1", 8080)
}
