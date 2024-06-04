#  MVVM(Model-View-View Model)

## Defination
- Model: Business object or domain object
- View: Represents the UI for the application
- View Model: Takes the data from the model and provides it to the view

## MVVM in WPF vs SwiftUI

- In SwiftUI, View is the ViewModel


## Limitations of the MVVM in SwiftUI

1. **Complexity**: MVVM can add unnecessary complexity if your app's requirements are simple. For small apps with only a few screens, using MVVM might be overkill.
2. **Tight Coupling**: In MVVM, the ViewModel is often tightly coupled with the View. This can make it difficult to reuse ViewModels across different views.
3. **State Management**: Managing state can become complex in large applications. SwiftUI's @State and @Binding are great for simple state, but for complex state, you might need to use @ObservedObject or @EnvironmentObject, which can add complexity.
4. **Testing**: While MVVM improves testability compared to MVC, testing the interaction between the View and the ViewModel can still be challenging.

[MV Pattern]( https://azamsharp.com/2022/08/09/intro-to-mv-state-pattern.html)
