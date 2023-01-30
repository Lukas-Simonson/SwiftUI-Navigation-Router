//
//  NavigationHandler.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

final public class NavigationHandler: ObservableObject {
    
    @Published var navPath = NavigationPath()
    @Published private(set) var routerPath = [any NavigationLocation]()
    
    public init() {}
    
    var popDisabled: Bool = false
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
    
    func push(_ destinations: [some View]) {
        for destination in destinations {
            let location = NavLocation(view: destination)
            navPath.append(location)
            routerPath.append(location)
        }
    }
}

// MARK: Popping
public extension NavigationHandler {
    func pop(_ amount: Int = 1) {
        navPath.removeLast(amount)
        routerPath.removeLast(amount)
        disablePop()
    }
    
    func safePop(_ amount: Int = 1) {
        if count > amount { pop(amount) }
        else { popToRoot() }
    }
    
    func popTo(_ index: Int) {
        pop((count - 1) - index)
    }
    
    func popTo<Content: View>(_ last: Content.Type) {
        guard let index = routerPath.lastIndex(where: { type(of: $0) == last })
        else { return }
        pop((count - 1) - index)
    }
    
    func popToView(where predicate: (any NavigationLocation) -> Bool ) {
        guard let index = routerPath.lastIndex(where: predicate)
        else { return }
        pop((count - 1) - index)
    }
    
    func popToRoot() {
        navPath = NavigationPath()
        routerPath = []
        disablePop()
    }
    
    func disablePop() {
        popDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in self?.popDisabled = false }
    }
}


