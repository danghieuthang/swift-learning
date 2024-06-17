import Combine
import UIKit

// filter

let numersPublisher = (1 ... 10).publisher

let evenNumberPublisher = numersPublisher.filter { $0 % 2 == 0 }

evenNumberPublisher.sink { value in
    print(value)
}
