package basics 

import "core:fmt"

Cat :: struct {
  name:string,
  age:int,
}

structs :: proc() -> Cat {
  cat1 : Cat
  
  cat2 := Cat {
    name = "Hello",
    age = 3,
  }
  return cat2
}