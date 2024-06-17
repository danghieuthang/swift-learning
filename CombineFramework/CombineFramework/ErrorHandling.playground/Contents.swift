import Combine
import UIKit

enum NumberError: Error {
    case operatiionFailed
}

let numbersPublisher = [1, 2, 3, 4, 5].publisher

// let doubledPublisher = numbersPublisher
//    .tryMap { number in
//
//        if number == 4 {
//            throw NumberError.operatiionFailed
//        }
//        return number * 2
//    }.catch { error in
//        if let numberError = error as? NumberError {
//            print("Error occurred: \(numberError)")
//        }
//        return Just(0)
//    }

let doubledPublisher = numbersPublisher
    .tryMap { number in
        if number == 4 {
            throw NumberError.operatiionFailed
        }
        return number * 2
    }.mapError { _ in
        NumberError.operatiionFailed
    }

let cancelable = doubledPublisher.sink { completion in
    switch completion {
    case .finished:
        print("finished")
    case .failure(let error):
        print(error)
    }
} receiveValue: { value in
    print(value)
}
