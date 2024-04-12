//
//  NavigatesTo.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

@available(*, deprecated, message: "Switch to using the new routerDestination API")
public extension View {
    
    /// Adds a `View` `Type` that can be navigated to into the current navigation route.
    ///
    /// - Parameters:
    ///   - type: The `View` `Type` to add to the navigation routes potential locations.
    ///   - backButtonDisabled: A `Bool` that dictates if this given `View` destination needs to use a toolbar back button, enabled by default.
    ///   - backSwipeDisabled: A `Bool` that dictates if this given `View` destination uses the swipe to go back feature, enabled by default.
    ///   - titleDisabled: A `Bool` that dicated if this given `View` destination should display a title.
    ///
    func navigatesTo<Content: View>(
        _ type: Content.Type,
        backButtonDisabled: Bool = false,
        backSwipeDisabled: Bool = false,
        titleDisabled: Bool = false
    ) -> some View {
        navigationDestination(for: NavigationHandler.NavLocation<Content>.self) { location in
            location.view.modifier(NavigatesTo(
                backButtonDisabled: backButtonDisabled,
                backSwipeDisabled: backSwipeDisabled,
                title: titleDisabled ? nil : location.userData["name"] as? String
            ))
        }
    }
}

/// A `ViewModifier` that adds a destination `View` to the parent `NavigationRouter`.
private struct NavigatesTo: ViewModifier {
    
    @NavRouter var router
    var backButtonDisabled: Bool
    var backSwipeDisabled: Bool
    var title: String?
    
    func body(content: Content) -> some View {

        if backButtonDisabled {
            noToolbar(content: content)
                .modifier(OptionalTitle(title: title))
                .gesture(backSwipeDisabled ? DragGesture() : nil)
        }
        else {
            usesToolbar(content: content)
                .modifier(OptionalTitle(title: title))
                .gesture(backSwipeDisabled ? DragGesture() : nil)
        }
    }
    
    private func noToolbar(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
    }

    private func usesToolbar(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                if router.navPath.count > 0 {

                    #if os(macOS)
                    let placement = ToolbarItemPlacement.navigation
                    #else
                    let placement = ToolbarItemPlacement.navigationBarLeading
                    #endif

                    ToolbarItem(placement: placement) {
                        Button {
                            router.pop()
                        } label: {
                            Label("Back", systemImage: "chevron.backward")
                                .labelStyle(.titleAndIcon)
                        }
                    }
                }
            }
    }
    
    private struct OptionalTitle: ViewModifier {
        
        var title: String?
        
        func body(content: Content) -> some View {
            if let title = title {
                content
                    .navigationTitle(title)
            } else {
                content
            }
        }
    }
}
