//
//  File.swift
//  
//
//  Created by Lukas Simonson on 1/30/23.
//

import Foundation

/// A Protocol used to identify `Views` inside a `NavigationController`
public protocol NavigationLocation: Hashable, Identifiable {
    associatedtype Content
    
    /// A Unique Identifier given this `NavigationLocation`
    var id: UUID { get }
    
    /// The `View` this `NavigationLocation` is used to wrap.
    var view: Content { get }
    
    /// A `Dictionary<String : Any>` uses to store extra identification data inside this `NavigationLocation`
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
