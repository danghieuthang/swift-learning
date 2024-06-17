import Combine
import UIKit

// combineLatest

// let publisher1 = CurrentValueSubject<Int, Never>(1)
// let publisher2 = CurrentValueSubject<Int, Never>(2)
//
// let combinePublisher = publisher1.combineLatest(publisher2)
//
// let cancellables = combinePublisher.sink { value1, value2 in
//    print("value 1: \(value1), Value 2: \(value2)")
// }

// publisher1.send(4)
// publisher2.send(5)

// zip

let publisher1 = [1, 2, 3, 4].publisher
let publisher2 = ["A", "B", "C"].publisher
let publisher3 = ["MOT", "Hai", "BA"].publisher
let zippedPublisher = Publishers.Zip3(publisher1, publisher2, publisher3)

let cancelables = zippedPublisher.sink { value in
    print("\(value.0),\(value.1),\(value.2)")
}
