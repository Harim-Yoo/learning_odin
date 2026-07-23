package basics

import "core:fmt"

pointers :: proc(cat: ^Cat) {
  fmt.printf("Fetched by pointer : Name:%v, Age:%v\n", cat.name, cat.age)
  fmt.printf("Address:%p\n", cat) // %v gives you the full object, but %p gives you the pointer.
  cat.age = 10
  fmt.printf("The age has changed into %v\n", cat.age)
}