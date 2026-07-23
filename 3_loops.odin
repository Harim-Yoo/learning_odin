package basics

import "core:fmt"
loops :: proc(n:int) -> int {
  res := 0 
  for i in 0..<5 {
    fmt.printf("%v\n",i)
    res += i
  }
  return res
}