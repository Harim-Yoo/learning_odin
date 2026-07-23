package basics

import "core:fmt"

main :: proc() {
  fmt.println("Hello World") // almost same as Go, except it starts with small p, not capital P.
  variables() // calling procedures under the same package. Same as Go.
  res := loops(5) // Same as Go.
  fmt.printf("Return value after the loop:%v\n", res)

  if_statements(3)
  if_statements(100)

  cat := structs()
  fmt.printf("Name:%v, age:%v\n", cat.name, cat.age)
}

