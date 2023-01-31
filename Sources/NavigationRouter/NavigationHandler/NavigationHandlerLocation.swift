//
//  NavigationControllerLocation.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public extension NavigationHandler {
    
    /// A `NavigationLocation` used to identify views in a `NavigationController`.
    struct NavLocation<Content: View>: NavigationLocation {
        
        /// A Unique Identifier given this `NavLocation`
        public let id = UUID()
        
        /// The `View` this `NavLocation` is made to wrap.
        public let view: Content
        
        /// A `Dictionary<String : Any>` uses to store extra identification data inside this `NavLocation`
        public var userData: [String : Any] = [:]
    }
}

public extension NavigationHandler.NavLocation {
    static func == (lhs: NavigationHandler.NavLocation<Content>, rhs: NavigationHandler.NavLocation<Content>) -> Bool {
        lhs.id == rhs.id
    }
}
