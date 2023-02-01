//
//  NavigationHandler.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

/// `NavigationHandler` is a class used to handle all Navigation for a `NavigationRouter`.
final public class NavigationHandler: ObservableObject {
    
    /// A `SwiftUI.NavigationPath` used to handle navigation for `SwiftUI`.
    @Published internal var navPath = NavigationPath()
    
    /// An `Array<NavigationLocation>`, used to handle advanced navigation operations.
    @Published private var routerPath = [any NavigationLocation]()
    
    public init() {}
    
    /// Used to keep an enduser from navigating backwards faster than a `NavigationStack` can handle.
    private var popDisabled: Bool = false
}

// MARK: Information
public extension NavigationHandler {
    
    /// The number of elements in the current navigation route.
    var count: Int { routerPath.count }
    
    /// A Boolean value indicating whether the navigation route is empty.
    var isEmpty: Bool { routerPath.isEmpty }
    
    /// A Boolean value indicating whether the navigation route is not empty.
    var isNotEmpty: Bool { !routerPath.isEmpty }
    
    /// An `Array<NavigationLocation>` containing all locations inside the current navigation route.
    var pathHistory: [any NavigationLocation] { routerPath }
}

// MARK: Pushing
public extension NavigationHandler {
    
    /// Pushes a new `View` to the end of the current navigation route, displaying the new `View`.
    ///
    /// - Parameters:
    ///   - view: The `View` to navigate to.
    ///   - data: A `Dictionary<String : Any>` that can be used to store extra identification data when needed.
    ///
    func push<Content: View>(_ view: Content, with data: [String : Any] = [:]) {
        let location = NavLocation(view: view, userData: data)
        navPath.append(location)
        routerPath.append(location)
    }
    
    func push(_ views: [any View]) {
        for view in views {
            let type = "\(type(of: view))"
            var nav = NavLocation(view: AnyView(view))
            nav.userData["specializedViewType"] = getGenericType(nav)
//            navPath.append(nav)
            routerPath.append(nav)
            
            for loc in routerPath {
                if loc.view is AnyView {
                    print("AnyView")
                    print("Result: \(getGenericType(nav) == getGenericType(loc))")
                } else {
                    print("Not Any View")
                }
                
            }
            
//            print( nav.view is AnyView )
//            let locations: [any NavLocation] = [nav]
            print( nav.userData["viewType"] as! String == "\(type)" )
        }
    }
    
    func getGenericType<T>(_ value: T) -> String {
        let t = type(of: value)
        return "\(t)"
    }
}

// MARK: Popping
public extension NavigationHandler {
    
    /// Removes the last `View(s)` in the navigation route. Aka navigates back to a previous `View`.
    ///
    /// - Parameters:
    ///   - amount: The number of `Views` to go back, defaults to 1.
    ///
    func pop(_ amount: Int = 1) {
        guard !popDisabled else { return }
        navPath.removeLast(amount)
        routerPath.removeLast(amount)
        disablePop()
    }
    
    /// Removes the last `View(s)` in the navigation route. Navigates back to root when asked to navigate further than the current navigation route allows.
    ///
    /// - Parameters:
    ///   - amount: The number of `Views` to go back, defaults to 1.
    func safePop(_ amount: Int = 1) {
        if count > amount { pop(amount) }
        else { popToRoot() }
    }
    
    /// Removes all `Views` past the given index, navigating back to the passed position.
    ///
    /// - Parameters:
    ///   - index: The index of the `View` to navigate back to
    ///
    func popTo(_ index: Int) {
        pop((count - 1) - index)
    }
    
    /// Removes all `Views` up to the last `View` in the navigation route matching the given type. If there is no `View` with a matching type, no `Views` will be removed.
    ///
    /// - Parameters:
    ///   - last: The `View's` `Type` that you want to navigate back to.
    ///
    func popTo<Content: View>(_ last: Content.Type) {
        guard let index = routerPath.lastIndex(where: { type(of: $0) == last })
        else { return }
        pop((count - 1) - index)
    }
    
    /// Removes all `Views` up to the last `View` in the navigation route matching the given `NavigationLocation`. If there is no `View` with a matching type, no `Views` will be removed.
    ///
    /// - Parameters:
    ///   - location: A `NavigationLocation` from the current navigation route to navigate back to.
    ///
    func popTo(_ location: any NavigationLocation) {
        guard let index = routerPath.lastIndex(where: { $0.id == location.id })
        else { return }
        pop((count - 1) - index)
    }
    
    /// Removes all `Views` up to the last `View` in the navigation route that satisfies the given predicate. If there is no `View` with that satisfies the predicate, no `Views` will be removed.
    ///
    /// - Parameters:
    ///   - predicate: A `(NavigationLocation) -> Bool` used to find where to navigate back to.
    ///
    func popToView(where predicate: (any NavigationLocation) -> Bool ) {
        guard let index = routerPath.lastIndex(where: predicate)
        else { return }
        pop((count - 1) - index)
    }
    
    /// Removes all `Views` in the current navigation route and returns to the root `View`.
    func popToRoot() {
        guard !popDisabled else { return }
        navPath = NavigationPath()
        routerPath = []
        disablePop()
    }
    
    /// Disables the functions the Pop / Remove Views from the current navigation route. Re-enables the navigation after a short delay.
    private func disablePop() {
        popDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in self?.popDisabled = false }
    }
}


