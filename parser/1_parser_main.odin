package parser

import "core:fmt"
import "core:os"

main :: proc() {
  defer free_all(context.temp_allocator)

  fileDir := "./parser/test.md"
  data, _ := os.read_entire_file(fileDir,context.temp_allocator)
  //defer delete(data) -> were to use context.allocator, we must free them either at the end of main procedure or defer them just like Go.

  parsedData := parse(data)
  //defer delete(parsedData) -> were to use context.allocator, we would have freed them.
  for i in 0..<len(parsedData) {
    fmt.printf("%s\n",string(parsedData[i]))
  }
}

