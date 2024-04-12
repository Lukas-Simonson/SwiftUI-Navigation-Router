//
//  NavRouter.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

/// A `PropertyWrapper` used to access the `NavigationHandler` of the current navigation route.
@propertyWrapper public struct NavRouter: DynamicProperty {
    
    /// The `NavigationHandler` recieved from a `NavigationRouter`
    @Environment(NavigationHandler.self) private var router: NavigationHandler
    
    public init() {}
    
    public var wrappedValue: NavigationHandler {
        router
    }
}
