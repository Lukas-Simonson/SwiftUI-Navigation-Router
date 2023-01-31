//
//  File.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import Foundation

public protocol NavigationLocation: Hashable, Identifiable {
    associatedtype Content
    var id: UUID { get }
    var view: Content { get }
    var userData: [String : Any] { get set }
}

public extension NavigationLocation {
    static func ==(_ lhs: any NavigationLocation, _ rhs: any NavigationLocation) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
