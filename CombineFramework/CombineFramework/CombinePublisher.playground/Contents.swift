import UIKit

import Combine

let publisher = Just("Helo World")

let cancellable = publisher.sink { value in
    print(value)
}

cancellable.cancel()
