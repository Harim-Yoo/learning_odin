package tcp_server_from_scratch 

import "core:fmt"
import "base:intrinsics"
import "core:log"

Sockaddr_in :: struct #packed {
    sin_family: u16,
    sin_port: u16,
    sin_addr: u32,
    sin_zero: [8]u8
  }

convert_port :: proc(port : u16) -> u16 {
    return (port >> 8) | (port << 8)
  }

main :: proc() {
  socket_number :: 41 // cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep socket
  AF_INET :: 2 //IPv4
  TCP_SOCKET :: 1 
  IPPROTO_IP :: 0 // <netinet.h> We have found the dummy protocol for TCP.
  socket_bind :: 49 // cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep bind
  listen_number :: 50 // cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep listen
  accept_number :: 43 // cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | gren accept 

  @(require_results)
  check_err :: proc(input:uintptr, loc := #caller_location)-> uintptr {
    if cast(i64)input < 0 {
      log.errorf("Syscall failed:%v\n",cast(i64)input)
      panic("panic")
    }
    return input
  }

  // 1. Open a socket with syscall.
  fd_ptr := check_err(intrinsics.syscall(socket_number, AF_INET, TCP_SOCKET, IPPROTO_IP))

  // cat /usr/include/netinet/in.h to find sockaddr_in struct 
  /*
  struct sockaddr_in {
    __SOCKADDR_COMM0N (sin_); // I did not know what that is. Apparently, this is C #define method Kernel developers used.
    in_port_t sin_port; //port number
    struct in_addr sin_addr //internet address
    unsigned char sin_zero[sizeof (struct sockaddr)
                          - __SOCKADDR_COMMON_SIZE
                          - sizeof (in_port_t)
                          - sizeof (struct in_addr)];
  
  }
  */
  
  // Get data ready.
  my_addr := Sockaddr_in {
    sin_family = AF_INET,
    sin_port = convert_port(8080),
    sin_addr = 0,
  }

  // 2. Bind data, but the way it works is that Kernel now accepts uintptr(fd_ptr) and bind the information on and forth. 
  bind_res := check_err(intrinsics.syscall(socket_bind, uintptr(fd_ptr), uintptr(&my_addr),size_of(my_addr)))

  //3. Getting ready to listen.
  listen_res := check_err(intrinsics.syscall(listen_number, uintptr(fd_ptr), 128)) // backlog allowed upto 128

  client_addr : Sockaddr_in
  client_addr_len : i32 = size_of(client_addr)

  client_fd_ptr := check_err(intrinsics.syscall(accept_number, uintptr(fd_ptr), uintptr(&client_addr), uintptr(&client_addr_len)))
  fmt.printf("Client's File Descripter :%v\n",cast(i32)client_fd_ptr) // connection reset by peer, of course... :)
}