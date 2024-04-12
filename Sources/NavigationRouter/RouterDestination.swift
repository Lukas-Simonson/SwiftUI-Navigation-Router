//
//  RouterDestination.swift
//  
//
//  Created by Lukas Simonson on 4/11/24.
//

import SwiftUI

public extension View {
    func routerDestinations<C: View>(_ type: C.Type) -> some View {
        navigationDestination(for: NavigationHandler.NavLocation<C>.self, destination: { $0.view })
    }
    
    func routerDestinations<C: View, C1: View>(_ c: C.Type, _ c1: C1.Type) -> some View {
        self
            .navigationDestination(for: NavigationHandler.NavLocation<C>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C1>.self, destination: { $0.view })
    }
    
    func routerDestinations<C: View, C1: View, C2: View>(_ c: C.Type, _ c1: C1.Type, _ c2: C2.Type) -> some View {
        self
            .navigationDestination(for: NavigationHandler.NavLocation<C>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C1>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C2>.self, destination: { $0.view })
    }
    
    func routerDestinations<C: View, C1: View, C2: View, C3: View>(_ c: C.Type, _ c1: C1.Type, _ c2: C2.Type, _ c3: C3.Type) -> some View {
        self
            .navigationDestination(for: NavigationHandler.NavLocation<C>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C1>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C2>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C3>.self, destination: { $0.view })
    }
    
    func routerDestinations<C: View, C1: View, C2: View, C3: View, C4: View>(_ c: C.Type, _ c1: C1.Type, _ c2: C2.Type, _ c3: C3.Type, _ c4: C4.Type) -> some View {
        self
            .navigationDestination(for: NavigationHandler.NavLocation<C>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C1>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C2>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C3>.self, destination: { $0.view })
            .navigationDestination(for: NavigationHandler.NavLocation<C4>.self, destination: { $0.view })
    }
}
