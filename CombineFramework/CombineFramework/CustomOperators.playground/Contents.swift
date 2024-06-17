import Combine
import UIKit

extension Publisher where Output == Int {
    func filterEvenNumbers() -> AnyPublisher<Int, Failure> {
        return self.filter { $0 % 2 == 0 }
            .eraseToAnyPublisher()
    }

    func filterNumberGreaterThan(_ value: Int) -> AnyPublisher<Int, Failure> {
        return self.filter { $0 > value }
            .eraseToAnyPublisher()
    }
}

let publisher = (1 ... 10).publisher

print("filterEvenNumbers")
let cancellable = publisher.filterEvenNumbers()
    .sink { value in
        print(value)
    }

print("filterNumberGreaterThan")
_ = publisher.filterNumberGreaterThan(5)
    .sink { value in
        print(value)
    }

extension Publisher {
    func mapAndFilter<T>(_ transform: @escaping (Output) -> T, _ isIncluded: @escaping (T) -> Bool) -> AnyPublisher<T, Failure> {
        return self
            .map { transform($0) }
            .filter { isIncluded($0) }
            .eraseToAnyPublisher()
    }
}

print("mapAndFilter")
let publisher1 = (1 ... 10).publisher
_ = publisher1
    .mapAndFilter { value in
        value * 2
    } _: { value in
        value % 2 == 0
    }
    .sink { value in
        print(value)
    }
