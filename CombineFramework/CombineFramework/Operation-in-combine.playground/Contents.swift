import Combine
import UIKit

let numbersPublisher = (1 ... 5).publisher

let squaredPublisher = numbersPublisher.map { $0 * $0 }

let cancelale = squaredPublisher.sink { value in
    print(value)
}

// flatMap
let namePublisher = ["John", "Mary", "Steven"].publisher

let flattedNamePublisher = namePublisher.flatMap { name in
    name.publisher
}

flattedNamePublisher
    .sink { char in
        print(char)
    }

// Merge
let publisher1 = (1 ... 6).publisher
let publisher2 = (6 ... 9).publisher

let mergePublisher = Publishers.Merge(publisher1, publisher2)

let cancellables = mergePublisher.sink { value in
    print(value)
}
