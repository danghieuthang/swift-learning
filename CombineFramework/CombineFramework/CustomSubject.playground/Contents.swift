import Combine
import UIKit

class EvenSubject<Failure: Error>: Subject {
    typealias Output = Int
    private let wrapped: PassthroughSubject<Int, Failure>
    init(initialValue: Int) {
        self.wrapped = PassthroughSubject()
        let evenInitialValue = initialValue % 2 == 0 ? initialValue : 0
        send(initialValue)
    }

    func send(_ value: Int) {
        if value % 2 == 0 {
            wrapped.send(value)
        }
    }

    func send(subscription: any Subscription) {
        wrapped.send(subscription: subscription)
    }

    func send(completion: Subscribers.Completion<Failure>) {
        wrapped.send(completion: completion)
    }

    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Int == S.Input {
        wrapped.receive(subscriber: subscriber)
    }
}

let subject = EvenSubject<Never>(initialValue: 4)

let cancellable = subject.sink { value in
    print(value)
}

subject.send(3)
subject.send(13)
subject.send(30)
