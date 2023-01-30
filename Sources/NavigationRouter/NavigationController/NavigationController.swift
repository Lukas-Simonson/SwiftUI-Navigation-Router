//
//  NavRouter.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

final public class NavigationController: ObservableObject {
    
    internal init() {}
    
    @Published var navPath = NavigationPath()
    @Published var routerPath = [any NavigationLocation]()
}

public extension NavigationController {
    func pop() {
        
    }
    
    func safePop() {
        
    }
}
