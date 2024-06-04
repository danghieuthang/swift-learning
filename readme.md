
# List And Navigation
# State And Binding
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
# Weather app
# MVVM

