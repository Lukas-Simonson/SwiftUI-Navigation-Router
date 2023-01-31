# NavigationRouter
An alternative for SwiftUI NavigationStack. While using the NavigationStack for performance, NavigationRouter gives more control to navigating. It also gives easy access for programatic navigation.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler: open Xcode, click on `File -> Swift Packages -> Add Package dependency...` and use the repository URL (https://github.com/Lukas-Simonson/SwiftUI-Navigation-Router.git) to download the package.

In Xcode, when you are prompted for a Version or a Branch, we suggest you use the branch: main
If you need, or want to try some experimental features, you can use the branch: dev

Then in your View you just need to import NavigationRouter

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

Once you have added the NavigationRouter and added your Navigatable Views. You can start actually navigating! Pushing a View is very easy and can be done in 3 steps.

  - Gain access to the Router using the @NavRouter property wrapper
  - Make a `Button` that can call the navigation function or use an `onTapGesture` on an existing View.
  - Call the `push` function from the router.
  
Inside the Views that you need to navigate from go ahead an import `NavigationRouter`, and then we need to add a NavRouter property wrapper inside. It should look something like this.

```swift
import NavigationRouter

struct HomeView: View {
    
    // You can name this variable whatever, router is what we will use for these examples
    @NavRouter var router
    
    var body: some View {
        // View Body...
    }
}
```

Step one complete, now that we have access to our NavRouter we can use it to navigate. We can use the `push` function in order to do that. We can just call that function in any block, for example with a button:

```swift
var body: some View {
    Button("Navigate To View Two") {
        router.push(ViewTwo())
    }
}
```
 
 And there is step two and step three completed.
 
 The `push` function also has an additional parameter that can be used. This parameter is a `[String : Any]` Dictionary. This lets you tie some additional information to your View for specific purposes. You can call it like this.
 
 ```swift
 router.push(ViewTwo(), with: ["name" : "View Two"])
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
