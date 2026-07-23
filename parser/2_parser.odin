package parser 

import "core:bytes"

parse :: proc(readData : []u8) -> [dynamic][]u8 {
  
  if len(readData) == 0 {
    return [dynamic][]u8{}
  }
  buckets := make([dynamic][]u8, context.temp_allocator)
  buffer : []u8
  current_data := readData //immutable constant...
  for {
    n := bytes.index_byte(current_data, '\n')
    if n == -1 {
      append(&buckets,current_data)
      break 
    }
    buffer = current_data[:n]
    append(&buckets,buffer)
    current_data = current_data[n+1:]
  }
  return buckets
}
