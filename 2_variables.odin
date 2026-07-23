package basics 

import "core:fmt"

variables :: proc() {
  number: int // var number int in Go lang
  fmt.printf("Val:%v\n",number) //almost same feature as Go.

  number = 7
  fmt.printf("New val:%v\n", number)

  another_number:int = 10 
  fmt.printf("Another number:%v\n",another_number)
  
  yet_another_number := 12
  fmt.printf("Yet another number:%v\n",yet_another_number)

  floating_number := 8.2
  yet_floating_number:f32 = 8.3
  fmt.printf("Type:%v\n", typeid_of(type_of(yet_floating_number)))

}