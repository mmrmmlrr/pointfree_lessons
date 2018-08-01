
import UIKit

precedencegroup ForwardApplication {
  associativity: left
}

precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}

infix operator |>: ForwardApplication

func |> <A, B>(argument: A, function: (A) -> B) -> B {
  return function(argument)
}

func incr(_ int: Int) -> Int {
  return int + 1
}

func square(_ int: Int) -> Int {
  return int * int
}

let a = 10 |> incr |> square

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f:  @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
  return  { g(f($0)) }
}

func reverse(_ string: String) -> String {
  return String(string.reversed())
}


20 |> incr >>> square >>> String.init >>> reverse
[1, 2, 3, 4, 5].map(square >>> incr >>> square)
