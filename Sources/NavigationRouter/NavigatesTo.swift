//
//  NavigatesTo.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public extension View {
    func navigatesTo<Content: View>(_ type: Content.Type) -> some View {
        navigationDestination(for: NavigationHandler.NavLocation<Content>.self) { location in
            location.view.modifier(NavigatesTo())
        }
    }
}

private struct NavigatesTo: ViewModifier {
    
    @NavRouter var router
    
    func body(content: Content) -> some View {
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
