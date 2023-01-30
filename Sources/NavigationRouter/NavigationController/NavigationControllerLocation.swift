//
//  NavigationControllerLocation.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import SwiftUI

public extension NavigationController {
    struct NavLocation<Content: View>: NavigationLocation {
        public let id = UUID()
        public let view: Content
        public var userData: [String : Any]
    }
}

public extension NavigationController.NavLocation {
    static func == (lhs: NavigationController.NavLocation<Content>, rhs: NavigationController.NavLocation<Content>) -> Bool {
        lhs.id == rhs.id
    }
}
