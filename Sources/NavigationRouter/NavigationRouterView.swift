//
//  NavigationRouterView.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

/// A `SwiftUI.View` used to handle Navigation
public struct NavigationRouter<Content>: View where Content: View {
    
    /// The `NavigationHandler` that dictates what this `NavigationRouter` shows.
    @StateObject private var router = NavigationHandler()
    
    /// The root `View` of this `NavigationRouter`
    private var root: () -> Content
    
    /// An initializer used to pass an already created `NavigationHandler`. Not recommended for regular use.
    ///
    /// - Parameters:
    ///   - router: The `NavigationHandler` for this `NavigationRouter` to use.
    ///   - root: A `View` to display as the base `View` of this `NavigationRouter`.
    ///
    public init(router: NavigationHandler, root: @escaping () -> Content) {
        self._router = StateObject(wrappedValue: router)
        self.root = root
    }
    
    /// The preferred Initializer to create a `NavigationRouter`.
    ///
    /// - Parameters:
    ///   - root: A `View` to display as the base `View` of this `NavigationRouter`.
    ///
    public init(root: @escaping () -> Content) {
        self.root = root
    }
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            rootView
                .navigatesTo(AnyView.self)
        }
        .environmentObject(router)
        .gesture(navSwipeBackGesture)
    }
    
    private var rootView: some View {
        root()
            .navigationBarBackButtonHidden(true)
    }
    
    private var navSwipeBackGesture: some Gesture {
        DragGesture(minimumDistance: 50)
            .onEnded { val in
                if val.translation.width > 50 && val.startLocation.x < 50 {
                    router.safePop()
                }
            }
    }
}
