import Combine
import UIKit

let timerPublsiher = Timer.publish(every: 1, on: .main, in: .common)

let cancellable = timerPublsiher.autoconnect().sink(receiveValue: { timespamp in
    print("Timestamp  \(timespamp)")
})
