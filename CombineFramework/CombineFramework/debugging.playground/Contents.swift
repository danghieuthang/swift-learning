import Combine
import UIKit

let publisher = (1 ... 10).publisher

_ = publisher
    .handleEvents { _ in
        print("Subcription received")
    } receiveOutput: { value in
        print("receoved ouput")
        print(value)
    } receiveCompletion: { _ in
        print("receive completion")
    } receiveCancel: {
        print("received cancel")
    } receiveRequest: { _ in
        print("receive request")
    }
    .map { value in
        value * 2
    }
    .sink { value in
        print("sink")
        print(value)
    }
