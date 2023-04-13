//
//  NavigatesTo.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public extension View {
    
    /// Adds a `View` `Type` that can be navigated to into the current navigation route.
    ///
    /// - Parameters:
    ///   - type: The `View` `Type` to add to the navigation routes potential locations.
    ///   - usesBackButton: A `Bool` that dictates if this given `View` `Type` needs to use a toolbar back button, enabled by default.
    func navigatesTo<Content: View>(_ type: Content.Type, usesBackButton: Bool = true) -> some View {
    func navigatesTo<Content: View>(_ type: Content.Type, usesBackButton: Bool = true, usesBackSwipe: Bool = true) -> some View {
        navigationDestination(for: NavigationHandler.NavLocation<Content>.self) { location in
            location.view.modifier(NavigatesTo(backButton: usesBackButton))
        }
    }
}

/// A `ViewModifier` given to all Views inside a `NavigationRouter`. Used to change some default functionality of a `NavigationStack`.
private struct NavigatesTo: ViewModifier {
    
    @NavRouter var router
    var backButton: Bool
    
    func body(content: Content) -> some View {
        if backButton { usesToolbar(content: content) }
        else { noToolbar(content: content) }
                .gesture(!backSwipe ? DragGesture() : nil)
        }
        else {
            noToolbar(content: content)
                .modifier(OptionalTitle(title: title))
                .gesture(!backSwipe ? DragGesture() : nil)
        }
    }
    
    func noToolbar(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
    }
    
    func usesToolbar(content: Content) -> some View {
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
    
}
