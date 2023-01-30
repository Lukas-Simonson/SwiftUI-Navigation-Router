//
//  NavigationRouterView.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public struct NavigationRouter<Content>: View where Content: View {
    
    @StateObject private var router = NavigationHandler()
    private var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            rootView
        }
        .environmentObject(router)
        .gesture(navSwipeBackGesture)
    }
    
    private var rootView: some View {
        content()
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
