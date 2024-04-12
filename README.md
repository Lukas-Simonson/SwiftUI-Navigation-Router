# NavigationRouter
An alternative for SwiftUI NavigationStack. While using the NavigationStack for performance, NavigationRouter gives more control to navigating. It also gives easy access for programatic navigation. NavigationRouter is type-safe and avoids using AnyView to make it as performant as possible.
## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

To add [SwiftUI-Navigation-Router](https://github.com/Lukas-Simonson/SwiftUI-Navigation-Router) to your project do the following.
- Open Xcode
- Click on `File -> Add Packages`
- Use this repositories URL (https://github.com/Lukas-Simonson/SwiftUI-Navigation-Router.git) in the top right of the window to download the package.
- When prompted for a Version or a Branch, we suggest you use the branch: main
  - If you need, or want to try some experimental features, you can use the branch: dev

## Quickstart Guide

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

In order to navigate to different views, the `NavigationRouter` needs to know what Views are navigable to. You can do this easily enough using the `routerDestinations` `ViewModifier`. You can either add them all to your root view, or specify them along the route. Here is a demonstration of the former.

```swift
struct RootView: View {
    var body: some View {
        NavigationRouter {
            HomeView()
                .routerDestinations(ViewTwo.self, ViewThree.self)
                .routerDestinations(ViewFour.self)
        }
    }
}
```
### Navigating Forward / Pushing Views

Once you have added the `NavigationRouter` and added your `Navigable Views`. You can start to navigate. Navigating Forwards / Pushing a View is super easy! You can either use a `PushView`, or gain access to the `Router` using the `@NavRouter` property wrapper, and then call the `push` function.

#### Using `PushView`

Using a `PushView` is the easiest way to navigate forward. Inside any file that you need to navigate in, import `NavigationRouter`, and then it's as easy as using a `NavigationLink`. `PushView` can be made either with a `String`, or a custom label `View`.

<sub>NOTE: `PushView` functions as a `Button` similar to `NavigationLink`</sub>
<sub>NOTE: `PushView` is a replacement to `NavigationLink`, using a `NavigationLink` within a `NavigationRouter` will lead to an assertion failure</sub>

```swift
struct ViewOne: View {
    var body: some View {
        VStack {
            // Using a Text for its View.
            PushView("Navigate to View Two", destination: ViewTwo())
            
            // Or
            
            // Using a Custom Label for its View.
            PushView(ViewTwo()) {
                // Custom Label View.
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
 
SwiftUIs `NavigationStack` offers very limited backwards navigation. You can go back once, a set number of times, or to the root. But navigation isn't always that simple. Often you might not know exactly how many times you need to go back, or you want to go back to a specific view, or maybe offer users a way to see all the different places they can navigate back to. This is where SwiftUI-Navigation-Router comes in. The `Router` offers many ways to navigate backwards, both programatically and/or using a `PopView`. 

Examples of ways you can navigate back that arent included in SwiftUIs `NavigationStack` by default include:

- Pop to a specific point in the route specified by an index.
- Pop back a set number of `Views`, safely returning to the root `View` if you try and navigate too far back.
- Pop back to the last `View` matching a given type of `View`.
- Retrieve an `Array` of different Locations to navigate to, and navigate back to them easily.
- Navigate back to a specific `View` matching a given predicate.

All of the above can be completed, including whats already a part of SwiftUIs `NavigationStack`, using a `PopView` or programatically using a `Router`.

#### Using PopView

Using a `PopView` is the easiest way to navigate backwards. Inside any file that you need to navigate back from import `NavigationRouter`, and then it's as easy as using a `NavigationLink`. `PopView` can be made either with a `String`, or a custom label `View`.

<sub>NOTE: `PopView` functions as a `Button` similar to `NavigationLink`</sub>

```swift
struct ViewTwo: View {
    var body: some View {
        VStack {
            // Using a Text for its View.
            PopView("Go Back One View")
            
            // Or
            
            // Using a Custom Label for its View.
            PopView {
                // Custom Label View.
                Image("BackOneViewImage")
            }
        }
    }
}
```

`PopView` also supports navigating back multiple levels, you can just specify the amount you want to go back.

```swift
PopView("Go Back Two Views", amount: 2)

// or

PopView(2) {
    Image("BackTwoViewsImage")
}
```

Finally `PopView` also supports all of the advanced navigation mentioned above. By replacing amount with a `PopType`. There will be a full description of these different `PopTypes` in the wiki. But here is an example on how to implement it to return to the root view.

```swift
PopView("Back To Root", popType: .root)

// or

PopView(.root) {
    Image("BackToRootImage")
}
```

#### Using Programatic Backward Navigation

Programatically navigating around with Navigation Router is almost as easy as using a `PopView`. We just have one extra step. We need to manuall get access to our `Router`. We can do that by using the `@NavRouter` property wrapper.

```swift
 struct ViewTwo: View {
     
     // You can name this variable whatever, router is what we will use for these examples.
     @NavRouter var router
     
     var body: some View {
         // View Body...
     }
 }
 ```
 
Now that we have access to our `Router` we can use it to navigate around. To pop a view you just need to call one of the `pop` functions. Typically you may want to do this in a `Button` or an `onTapGesture`; however, you can call it from wherever you need as long as you have access to the `Router`.

```swift
 var body: some View {
     Button("Navigate Back One View") {
         router.pop()
     }
 }
 ```
 
 You can also specify that you want to navigate multiple `Views` back by passing the number into the `pop` function.
 
 ```swift
 // Pops Back 2 Views
 router.pop(2)
 ```
 
Similar to the PopView there is access to all of those advanced navigation methods mentioned above. And you can either find those in the App documentation or the Wiki when its up.
