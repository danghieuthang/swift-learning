# SwiftUI Tutorials and Notes

This repository contains a collection of tutorials and notes from Mohammad Azam's Udemy course on SwiftUI. The content has been learned and documented for future reference.


## Table of Contents
1. [List and Navigation](#list-and-navigation)
2. [State and Binding](#state-and-binding)
    - [State](#state)
    - [Binding](#binding)
    - [ObservedObject](#observedobject)
    - [EnvironmentObject](#environmentobject)
3. [MVVM Pattern](#mvvm-pattern)
4. [MV Pattern](#mv-pattern)
5. [MV Pattern Validation](#mv-pattern-validation)
6. [Core Data](#core-data)
7. [Combine framework](#combine-framework)
## Topics Covered
### List And Navigation
### State And Binding
1. State: The @State property wrapper is used to create a mutable state for a value type. SwiftUI manages the storage of any property you declare as a state. When the state value changes, the view invalidates its appearance and recomputes the body.
```swift
@State private var isToggled = false
```
2. Binding: The @Binding property wrapper is used when you want to create a two-way connection between a variable and a view. When you modify the variable, the view updates, and when you modify the view, the variable updates.
```swift
@Binding var text: String
```
You can create a binding from a state like this:

```swift
Toggle(isOn: $isToggled) {
    Text("Toggle me")
}
```
3. ObservedObject: The @ObservedObject property wrapper is used when you want to create a mutable reference to a reference type that conforms to the ObservableObject protocol. When any of the object's @Published properties change, the view invalidates its appearance and recomputes the body.

```swift
class User: ObservableObject {
    @Published var name: String
}

struct ContentView: View {
    @ObservedObject var user: User
}
```

4. EnvironmentObject: The @EnvironmentObject property wrapper is used when you want to create a mutable reference to a reference type that conforms to the ObservableObject protocol and is provided as an environment value. When any of the object's @Published properties change, the view invalidates its appearance and recomputes the body.

```swift
class User: ObservableObject {
    @Published var name: String
}

struct ContentView: View {
    @EnvironmentObject var user: User
}
```
5. StateObject: The @StateObject property wrapper is used when you want to create a mutable reference to a reference type that conforms to the ObservableObject protocol and you want SwiftUI to manage the lifecycle of the object.

```swift
class User: ObservableObject {
    @Published var name: String
}

struct ContentView: View {
    @StateObject var user = User()
}
```

| Property Wrapper | Use Case | Example |
|------------------|----------|---------|
| `@State` | For simple properties that belong to a specific view and don't need to be shared or observed by other views. | A boolean that tracks whether a switch is on or off in a single view. |
| `@Binding` | When a value is owned by a parent view but a child view needs to mutate it. | A text field's text property in a reusable text field component. |
| `@ObservedObject` | When your view needs to mutate properties of an external object, and you want your view to update when those properties change. | A User object that is used across several views. |
| `@EnvironmentObject` | When multiple views need to share and mutate the same data. | Settings that affect many views in your app, or a shared data model. |


### MVVM Pattern

#### Defination
- Model: Business object or domain object
- View: Represents the UI for the application
- View Model: Takes the data from the model and provides it to the view

#### MVVM in WPF vs SwiftUI

- In SwiftUI, View is the ViewModel


#### Limitations of the MVVM in SwiftUI

1. **Complexity**: MVVM can add unnecessary complexity if your app's requirements are simple. For small apps with only a few screens, using MVVM might be overkill.
2. **Tight Coupling**: In MVVM, the ViewModel is often tightly coupled with the View. This can make it difficult to reuse ViewModels across different views.
3. **State Management**: Managing state can become complex in large applications. SwiftUI's @State and @Binding are great for simple state, but for complex state, you might need to use @ObservedObject or @EnvironmentObject, which can add complexity.
4. **Testing**: While MVVM improves testability compared to MVC, testing the interaction between the View and the ViewModel can still be challenging.

### MV Pattern
![MV Pattern](assets/mv-pattern.jpeg)
- MV Pattern: Where M stands for Model and V is for View
- MV Pattern Mechanics: The MV pattern involves a user action mutating the state, causing the view to re-render, simplifying the data flow in SwiftUI applications.
- Aggregate Root Concept: An observable object, called the aggregate root, serves as a gateway to model objects, centralizing logic and simplifying access to data.
```swift

// Ensure that code marked with it runs on the main thread
@MainActor
class StoreModel: ObservableObject {
    @Published var products: [Product] = []
    let webService: WebService
    init(webService: WebService) {
        self.webService = webService
    }

    func populateProducts() async throws {
        products = try await webService.getProducts()
    }

    func addProduct(){ 
        // TODO
    }
    ...
}

```

More about [MV Pattern](https://azamsharp.com/2022/08/09/intro-to-mv-state-pattern.html)

### Stop using MVVM with SwiftUI
- SwiftUI already has features like state and binding that eliminates the need for a separate view model layer.
- Using MVVM with SwiftUI requires passing around view models and global state which can be cumbersome and error-prone.
- SwiftUI encourages a unidirectional data flow which can be achieved without MVVM using environment objects.
- Core Data fetching can be done directly from the view without needing a view model.
- Unit testing becomes more complex with MVVM as the view model often doesn't contain any business logic.

[Read more](https://www.youtube.com/watch?v=LVx93PfGjdo)

### MV Pattern Validation

#### Simple
```swift
```
## Form Validation with Error Messages and Error Forms
- Extensions:
```swift
extension String {
    var isValidEmail: Bool {
        let emailRegex = "^[a-zA-Z0-9._%±]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}

```
- Form Error

```swift
struct LoginFormError {
    var email: String = ""
    var password: String = ""
}
```
- View
```swift
 struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginFormError = LoginFormError()

    private func clearForm() {
        loginFormError = LoginFormError()
    }

    var isFormValid: Bool {
        clearForm()
        if email.isEmpty {
            loginFormError.email = "Email is required"
        } else if !email.isValidEmail {
            loginFormError.email = "Email is not in correct format"
        }
        if password.isEmpty {
            loginFormError.password = "Password is required"
        }
        return loginFormError.email.isEmpty && loginFormError.password.isEmpty
    }

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            if !loginFormError.email.isEmpty {
                Text(loginFormError.email)
                    .font(.caption)
            }

            SecureField("Password", text: $password)
            if !loginFormError.password.isEmpty {
                Text(loginFormError.password)
                    .font(.caption)
            }
            Button("Login") {
                if isFormValid {}
            }
        }
    }
 }

```
#### Form Validation with View Model
- Login Error
```swift
enum LoginError: Error, LocalizedError {
    case emailEmpty
    case emailInvalid
    case passwordEmpty
    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email cannot be empty"
        case .emailInvalid:
            return "Email is not in correct format"
        case .passwordEmpty:
            return "Password cannot be empty"
        }
    }
}
```
- State
```swift
struct LoginState {
    var email: String = ""
    var password: String = ""
    var emailError: LoginError?
    var passwordError: LoginError?
    mutating func clearErrors() {
        emailError = nil
        passwordError = nil
    }

    mutating func isValid() -> Bool {
        clearErrors()
        if email.isEmpty {
            emailError = LoginError.emailEmpty
        } else if !email.isValidEmail {
            emailError = LoginError.emailInvalid
        }
        if password.isEmpty {
            passwordError = LoginError.passwordEmpty
        }
        return emailError == nil && passwordError == nil
    }
}

```
- View
```swift
struct LoginView: View {
    @State private var loginState = LoginState()

    var body: some View {
        Form {
            TextField("Email", text: $loginState.email)
                .textInputAutocapitalization(.never)
            if let emailError = loginState.emailError {
                Text(emailError.localizedDescription)
                    .font(.caption)
            }

            SecureField("Password", text: $loginState.password)
            if let passwordError = loginState.passwordError {
                Text(passwordError.localizedDescription)
                    .font(.caption)
            }
            Button("Login") {
                if loginState.isValid() {}
            }
        }
    }
}

```

#### Form Validation with Summary Messages
```swift
extension LocalizedError {
    var id: Int {
        localizedDescription.hashValue
    }
}

```



```swift
enum LoginError: LocalizedError, Identifiable {
    case emailEmpty
    case emailInvalid
    case passwordEmpty
    var id: Int {
        hashValue
    }

    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email cannot be empty"
        case .emailInvalid:
            return "Email is not in correct format"
        case .passwordEmpty:
            return "Password cannot be empty"
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errors: [LoginError] = []

    var isValid: Bool {
        errors = []
        if email.isEmpty {
            errors.append(.emailEmpty)
        } else if !email.isValidEmail {
            errors.append(.emailInvalid)
        }
        if password.isEmpty {
            errors.append(.passwordEmpty)
        }
        return errors.isEmpty
    }

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $password)
            Button("Login") {
                if isValid {
                    print("submit form")
                }
            }
            ValidationSummaryView(errors: errors)
        }
    }
}
```
```swift
extension LocalizedError {
    var id: Int {
        localizedDescription.hashValue
    }
}
```
```swift
struct ValidationSummaryView: View {
    let errors: [LocalizedError]
    var body: some View {
        ForEach(errors, id: \.id) { error in
            Text(error.localizedDescription)
        }
    }
}

```

### Core Data
Core Data is a framework provided by Apple for managing and persisting your app's data. It's essentially an object graph (and persistence) system that allows you to model your data in terms of objects, with relationships and inheritance. It can save these objects to disk, and fetch them when needed.
![Core Data Stack](/assets/CoreDataStack.png)
#### Core Data Manager
Core Data manager will be reponsible for setting up the core data stack
```swift
class CoreDataManager {
    /// Implemented as a singleton
    static let share = CoreDataManager()
    /// Encapsulates the core data stacks
    private var persistentContainer : NSPersistentContainer
    /// Make it private so nobody else can be initialize
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores{ description, error in
            if let error{
                fatalError("Unable to initialize Core data stack \(error)")
            }
        }
    
    }
    /// Property return the NS ManagedObjectContext, which can access from the persistent container
    var viewContext: NSManagedObjectContext{
        persistentContainer.viewContext
    }
}

```
#### Example code: [Budget App](./BudgetApp/)

[Some references](https://fxstudio.dev/basic-ios-tutorial-core-data)
### Combine Framework
#### Key Concepts
- Observable: An entity that produces data events. Example: User input, sensor data, API Responses
- Observer: An entity that listens to events emmited by observables. Example: Application components, views
- Operators: Functions to transform and manipulate data. Example: map, filter,...
#### Benefits
- Improved code readability
- Handling complex asynchronous scenarios
- Real-time and event-driven applications
#### User cases
- Web, mobile applications
- Real-time dashboards
- IoT and sensor data processing
#### Reactive vs Imperative

![Immutable vs mutable](./assets/Immutable%20vs%20mutable.png)
![Control flow](./assets/declarative%20vs%20explitcit.png)
![Control flow](./assets/synchronous%20vs%20asynchronous.png)


|   | Reactive Programming | Imperative Programming |
|---|----------------------|------------------------|
| Definition | Reactive programming is a declarative programming paradigm concerned with data streams and the propagation of change. | Imperative programming is a programming paradigm that uses statements that change a program's state. |
| Examples | In JavaScript, RxJS is a library for reactive programming. | In JavaScript, traditional event handling and callbacks are examples of imperative programming. |
| Advantages | Reactive programming can simplify the handling of asynchronous operations and events. It's easier to express complex control flows. | Imperative programming can be more straightforward and easier to understand, especially for simple tasks. It's often more flexible. |
| Disadvantages | Reactive programming can have a steep learning curve and may result in complex code for simple tasks. | Imperative programming can lead to more complex and less readable code when dealing with asynchronous operations and events. |

#### Combine
Combine is framework for handling asynchronous and even driven code in swift
[Cheatsheat](https://www.haozhexu.me/article/2023/swiftcombine)
1. Concepts
- **Publisher**: Emmit events
- **Subcriber**: Subcribe to receive the events
- **Operators**: Function to transform and maniplate data(map, filter, merge)
- **Subjects**: Special type of **Publiser** that is also **Subcribe**


2. **Publishers**
- Publishers in Combine emits values over time, objects that receive these values are subscribers - a subscriber subscribes to the output of a publisher
- Publishers is an enum, representing a namespace for publisher types, e.g.
- Publishers.Sequence is a publisher that publishes a given sequence of elements, e.g.
```swift
let publisher = ["cat", "dog", "monkey"].publisher
```
Data task publisher:
```swift
URLSession.shared.dataTaskPublisher(for: url)
```
Default notification center publisher:
```swift
NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotificaiton)
```
3. **Subscriber**
- *sink*: Attaches a subscriber with closure-based behavior.
```swift
["apple", "orange", "banana"].publisher.sink(receiveCompletion: { completion in
    print("completed: \(completion)")
}, receiveValue: { value in
    print("value received: \(value)")
})
```
- *assign*: Assigns each element from a publisher to a property on an object.
```swift
var player = Player()
["something nice"]
    .publisher
    .assign(to: \.introduction, on: player)
```
4. **Publisher Lifecycle**
- a publisher will not emit any value until it has a subscriber
sink and assign create subscribers that are always willing to receive values
- subscriber-driven emission has a terminology called backpressure management
- both sink and assign return an AnyCancellable, when it’s deallocated, the subscription associated with the object is destroyed
- AnyCancellable has a store(in:) method, takes an inout parameter, can be used to append the AnyCancellable to a set
- Combine comes with a number of operators that can be used to transform the values received from publisher, e.g.
5. **Error Handling**
```swift
enum NumberError: Error {
    case operatiionFailed
}

let numbersPublisher = [1, 2, 3, 4, 5].publisher

let doubledPublisher = numbersPublisher
    .tryMap { number in

        if number == 4 {
            throw NumberError.operatiionFailed
        }
        return number * 2
    }.catch { error in
        if let numberError = error as? NumberError {
            print("Error occurred: \(numberError)")
        }
        return Just(0)
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

```
or
```swift
import Combine
import UIKit

enum NumberError: Error {
    case operatiionFailed
}

let numbersPublisher = [1, 2, 3, 4, 5].publisher

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

```
6. **Transformation operators**

- Map
```swift
let numbersPublisher = (1 ... 5).publisher

let squaredPublisher = numbersPublisher.map { $0 * $0 }

let cancelale = squaredPublisher.sink { value in
    print(value)
}
```
- FlatMap
```swift
let namePublisher = ["John", "Mary", "Steven"].publisher

let flattedNamePublisher = namePublisher.flatMap { name in
    name.publisher
}

flattedNamePublisher
    .sink { char in
        print(char)
    }

```
- Merge
```swift
let publisher1 = (1 ... 6).publisher
let publisher2 = (6 ... 9).publisher

let mergePublisher = Publishers.Merge(publisher1, publisher2)

let cancellables = mergePublisher.sink { value in
    print(value)
}

```
7. **Filter Operators**
- Filter: Republishes all elements that match a provided closure.
```swift
let numersPublisher = (1 ... 10).publisher

let evenNumberPublisher = numersPublisher.filter { $0 % 2 == 0 }

evenNumberPublisher.sink { value in
    print(value)
}
```
- CompactMap: This operator receives each output from the upstream publisher and transforms it by applying a function you specify. If the function returns a non-nil result, CompactMap republishes the unwrapped result. If the function returns nil, CompactMap ignores the output.
- Debounce: 
Built-in operator that limits publisher’s output by ignoring values that are rapidly followed by another value.
- RemoveDuplicates: Publishes only elements that don’t match the previous element.
- throttle: Publishes either the most-recent or first element published by the upstream publisher in the specified time interval.
8. **Combining Operators**
- Publishers.Zip
A publisher created by applying the zip function to two upstream publishers.

Use Publishers.Zip to combine the latest elements from two publishers and emit a tuple to the downstream. The returned publisher waits until both publishers have emitted an event, then delivers the oldest unconsumed event from each publisher together as a tuple to the subscriber.

If either upstream publisher finishes successfully or fails with an error, so too does the zipped publisher.
```swift

let publisher1 = [1, 2, 3, 4].publisher
let publisher2 = ["A", "B", "C"].publisher
let publisher3 = ["MOT", "Hai", "BA"].publisher
let zippedPublisher = Publishers.Zip3(publisher1, publisher2, publisher3)

let cancelables = zippedPublisher.sink { value in
    print("\(value.0),\(value.1),\(value.2)")
}

```

- Publishers.Merge
A publisher created by applying the merge function to two upstream publishers.

Publishers.Merge emits a new value every time one of the publishers it merges emits a new value. Only a single value is emitted by interleaving all emiited values from the publishers that it merges.

Apple provides various versions of Publishers.Merge up to Publishers.Merge8 and Publishers.MergeMany. All versions of Pubilshers.Merge require that the publishers being merged have the same Output and Failure types.
- Publishers.CombineLatest
Subscribes to an additional publisher and invokes a closure upon receiving output from either publisher.

```swift
let publisher1 = CurrentValueSubject<Int, Never>(1)
let publisher2 = CurrentValueSubject<Int, Never>(2)

let combinePublisher = publisher1.combineLatest(publisher2)

let cancellables = combinePublisher.sink { value1, value2 in
    print("value 1: \(value1), Value 2: \(value2)")
}

publisher1.send(4)
publisher2.send(5)

```

- switchToLatest
Republishes elements sent by the most recently received publishers. Every time a publisher receives a new ‘Publisher’ as output, the previous subscriptions from the stream will automatically be cancelled.

8. **Subject**
- *Custom Subject*
```swift
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
```
#### Networking Using Combine