//
//  NavRouter.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

@propertyWrapper public struct NavRouter: DynamicProperty {
    @EnvironmentObject public var router: NavigationController
    
    public init() {}
    
    public var wrappedValue: NavigationController {
        router
    }
}
