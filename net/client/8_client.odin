package main 

import "core:os"
import "core:net"
import "core:fmt"

tcp_echo_client :: proc(ip:string, port:int) {

  // parse ip address into ip4 type
  address, success := net.parse_ip4_address(ip)
  ensure(success)

  //This is a client-side. We are dialing up the number.
  socket, err := net.dial_tcp_from_address_and_port(address, port)
  ensure(err == nil)

  //prepare byte-size
  buffer : [256]u8

  for {
    //send procedure

    n, err_read := os.read(os.stdin, buffer[:])
    assert(err_read == nil)

    if n == 0 {
      break
    }

    if n == 1 && buffer[0] == '\n' {
      break 
    }

    data := buffer[:n] //read upto the n-size data
    
    bytes_sent, err_sent := net.send_tcp(socket,data)
    ensure(err_sent == nil)

    sent := data[:bytes_sent]
    fmt.printf("Client sent (%v bytes): %v\n", len(sent), string(sent))

    //receive procedure 

    recv_bytes, recv_err := net.recv_tcp(socket,buffer[:])
    ensure(recv_err == nil)

    received := buffer[:recv_bytes]
    fmt.printf("Client received (%v bytes):%v\n", len(received), string(received))

  }

  //close socket
  net.close(socket)
}

main :: proc() {
  tcp_echo_client("127.0.0.1",8080)
}