# NavigationRouter
An alternative for SwiftUI NavigationStack. While using the NavigationStack for performance, NavigationRouter gives more control to navigating. It also gives easy access for programatic navigation.

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

To add [SwiftUI-Navigation-Router](https://github.com/Lukas-Simonson/SwiftUI-Navigation-Router) to your project do the following.
- Open Xcode
- Click on `File -> Add Packages`
- Use this repositories URL (https://github.com/Lukas-Simonson/SwiftUI-Navigation-Router.git) in the top right of the window to download the package.
- When prompted for a Version or a Branch, we suggest you use the branch: main
  - If you need, or want to try some experimental features, you can use the branch: dev

## Usage

### Adding the Navigation Router

`NavigationRouter` is a View that is used in place of a `NavigationStack`. It mimics all the features of a `NavigationStack` but adds flexibility in many ways. In order to use it we first need to import the `NavigationRouter` module.

```swift
import SwiftUI
import NavigationRouter
```

Then you can either replace your current `NavigationStack`, or ( if in a new project ) put the `NavigationRouter` at your root view. Like so:

```swift
struct RootView: View {
    var body: some View {
        NavigationRouter {
            HomeView()
        }
    }
}
```

### Adding Navigatable Views

In order to navigate to different views the `NavigationRouter` needs to know what Views are navigatable to. You can do this easily enough using the `navigatesTo` ViewModifier. You can either add them all to your root view, or specify them along the route. Here is a demonstration of the former.

```swift
struct RootView: View {
    var body: some View {
        NavigationRouter {
            HomeView()
                .navigatesTo(ViewTwo.self)
                .navigatesTo(ViewThree.self)
                .navigatesTo(ViewFour.self)
        }
    }
}
```
By default all Views, excluding the root view, have a back button in the top-leading location of the Navigation Tool Bar. If you have a custom back navigation button, you can disable this button using a parameter on the `navigatesTo` ViewModifier. Like so:

```swift
// Inside a NavigationRouter...
HomeView()
    .navigatesTo(ViewTwo.self, usesBackButton: false)
```

### Navigating Forward / Pushing Views

Once you have added the `NavigationRouter` and added your `Navigatable Views`. You can start to navigate. Navigation Forwards / Pushing a View is super easy! You can either use a `PushView`, or gain access to the `Router` using the `@NavRouter` property wrapper, and then call the `push` function.

#### Using PushView

Using a `PushView` is the easiest way to navigate forward. Inside any file that you need to navigate it import `NavigationRouter`, and then its as easy as using a `NavigationLink`. `PushView` can be made either with a `String`, or a custom label `View`.

<sub>NOTE: `PushView` functions as a `Button` similar to `NavigationLink`</sub>

```swift
struct ViewOne: View {
    var body: some View {
        VStack {
            // Using a Text for its View.
            PushView("Navigate to View Two", destination: ViewTwo())
            
            // Or
            
            // Using a Custom Label for its View.
            PushView(ViewTwo()) {
                // Custom Label View
                Image("MyNavigationImage")
            }
        }
    }
}
```

#### Using Programatic Forward Navigation

Programatically navigating around with Navigation Router is almost as easy as using a `PushView`. We just have one extra step. We need to manually get access to our `Router`. We can do that by using the `@NavRouter` property wrapper.

```swift
struct ViewOne: View {
    
    // You can name this variable whatever, router is what we will use for these examples.
    @NavRouter var router
    
    var body: some View {
        // View Body...
    }
}
```

Now that we have access to our `Router` we can use it to navigate around. To push a view its as easy as calling the `push` function. Typically you may do this inside of a `Button` or an `onTapGesture`; however, you can call it from wherever you need to, thats the beauty of using programatic navigation.

```swift
var body: some View {
    Button("Navigate To View Two") {
        router.push(ViewTwo())
    }
}
```

When using programatic navigation we can use an additional parameter of the `push` function. This parameters is a `[String : Any]` Dictionary. This lets you tie some additional information to your `View` for specific purposes.

```swift
router.push(ViewTwo(), with: ["name" : "View Two", "totalViews" : 6])
```
 
### Navigating Backwards / Popping Views
 
 Simple backwards navigation functions in the same way as pushing a view, just instead of using the `push` function, you can use the `pop` function. Throw it inside a button or just any function and youre golden, something like the following:
 
```swift
var body: some View {
    Button("Navigate Back A View") {
        router.pop()
    }
}
```

Pop also can take a parameter for how many views you want to navigate back. You can use it like so

```swift
// Navigate Back 2 Views
router.pop(2)
```

There are several different pop functions, all of which have documentation in Xcode, and at somepoint there will be a Wiki that will cover them more. So feel free to look through the documentation and see it all!
