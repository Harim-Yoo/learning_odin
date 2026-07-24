package arena_allocator

import "core:fmt"
import "core:os"
import vmem "core:mem/virtual"


load_files :: proc() -> (string, vmem.Arena) {
  arena : vmem.Arena // initialize the arena
  arena_err := vmem.arena_init_growing(&arena) // why such code?
  assert(arena_err == nil) // why this code?
  arena_alloc := vmem.arena_allocator(&arena) // I get that this is an initializing process

  data, data_err := os.read_entire_file("./arena_allocator/test1.txt", arena_alloc)
  assert(data_err == nil)
  return string(data), arena
}


main :: proc() {
  
  file, arena := load_files()
  fmt.printf("Here is the string read: %v\n",file)

  vmem.arena_destroy(&arena)
  
}