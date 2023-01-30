//
//  NavigationControllerLocation.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public extension NavigationHandler {
    struct NavLocation<Content: View>: NavigationLocation {
        public let id = UUID()
        public let view: Content
        public var userData: [String : Any]
    }
}

public extension NavigationHandler.NavLocation {
    static func == (lhs: NavigationHandler.NavLocation<Content>, rhs: NavigationHandler.NavLocation<Content>) -> Bool {
        lhs.id == rhs.id
    }
}
