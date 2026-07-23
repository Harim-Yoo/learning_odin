package basics

import "core:fmt"

if_statements :: proc(some_number:int) {
  
  //This will always happens no matter what.
  if true {
    fmt.println("This always happens")
  }

  if some_number > 10 {
    fmt.printf("The input %v is bigger than 10.\n", some_number)
  }

  a_condition := some_number < 100
  
  if a_condition {
    fmt.println("The input is smaller than 100.\n")
  } else {
    fmt.println("The input is not smaller than 100.\n")
  }

}