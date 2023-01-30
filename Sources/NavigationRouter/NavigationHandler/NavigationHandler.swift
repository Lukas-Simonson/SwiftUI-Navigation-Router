//
//  NavigationHandler.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

final public class NavigationHandler: ObservableObject {
    
    internal init() {}
    
    @Published var navPath = NavigationPath()
    @Published private(set) var routerPath = [any NavigationLocation]()
}

// MARK: Information
public extension NavigationHandler {
    var count: Int { routerPath.count }
    var isEmpty: Bool { routerPath.isEmpty }
    var isNotEmpty: Bool { !routerPath.isEmpty }
}

// MARK: Pushing
public extension NavigationHandler {
    func push<Content: View>(_ view: Content, with data: [String : Any] = [:]) {
        let location = NavLocation(view: view, userData: data)
        navPath.append(location)
        routerPath.append(location)
    }
}

// MARK: Popping
public extension NavigationHandler {
    func pop(_ amount: Int = 1) {
        navPath.removeLast(amount)
        routerPath.removeLast(amount)
    }
    
    func safePop(_ amount: Int = 1) {
        if count > amount { pop(amount) }
        else { popToRoot() }
    }
    
    func popToRoot() {
        navPath = NavigationPath()
        routerPath = []
    }
}


