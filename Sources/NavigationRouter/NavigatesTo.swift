//
//  NavigatesTo.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public extension View {
    func navigatesTo<Content: View>(_ type: Content.Type, usesBackButton: Bool = true) -> some View {
        navigationDestination(for: NavigationHandler.NavLocation<Content>.self) { location in
            location.view.modifier(NavigatesTo(backButton: usesBackButton))
        }
    }
}

private struct NavigatesTo: ViewModifier {
    
    @NavRouter var router
    var backButton: Bool
    
    func body(content: Content) -> some View {
        if backButton { usesToolbar(content: content) }
        else { noToolbar(content: content) }
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
