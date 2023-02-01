//
//  PopView.swift
//
//
//  Created by Lukas Simonson on 2/1/23.
//

import SwiftUI

/// A `Button` that removes a `View` to the current Navigation Route.
public struct PopView<Label : View> : View {
    
    /// Gives access to the current Navigation Route.
    @NavRouter private var router
    
    /// The label to display.
    private var label: Label
    
    /// The Navigation Route Action to Perform.
    private var pop: (NavigationHandler) -> Void = { _ in }
    
    public var body: some View {
        Button(action: { pop(self.router) }, label: { label })
    }
    
    /// Creates a `PopView` that displays a custom label.
    ///
    /// - Parameters:
    ///   - amount: The number of `Views` to remove from the current Navigation Route.
    ///   - label: A `View` that describes where this butotn will navigate to.
    ///
    public init(_ amount: Int = 1, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.pop = { $0.pop(amount) }
    }
    
    /// Creates a `PopView` that displays a custom label.
    ///
    /// - Parameters:
    ///   - popType: The way this `PopView` will navigate backwards.
    ///   - label: A `View` that describes where this butotn will navigate to.
    ///
    public init(_ popType: PopType = .pop(amount: 1), @ViewBuilder label: () -> Label) {
        self.label = label()
        
        switch popType {
            case .pop(let amount): self.pop = { $0.pop(amount) }
            case .safePop(let amount): self.pop = { $0.safePop(amount) }
            case .toIndex(let index): self.pop = { $0.popTo(index) }
            case .last(let viewType): self.pop = { $0.popTo(viewType) }
            case .location(let navLocation): self.pop = { $0.popTo(navLocation) }
            case .wherePredicate(let predicate): self.pop = { $0.popToView(where: predicate) }
            case .root: self.pop = { $0.popToRoot() }
        }
    }
}

extension PopView {
    
    /// The different ways this `PopView` can navigate backwards.
    public enum PopType {
        case pop(amount: Int = 1)
        case safePop(amount: Int = 1)
        case toIndex(index: Int)
        case last(viewType: any View.Type)
        case location(navLocation: any NavigationLocation)
        case wherePredicate(predicate: (any NavigationLocation) -> Bool)
        case root
    }
}

extension PopView where Label == Text {
    
    /// Creates a `PopView` that generates its label from a `LocalizedStringKey`
    ///
    /// - Parameters:
    ///   - titleKey: The key for this `PopView's` localized title, that describes what this `PopView` does.
    ///   - amount: The number of `Views` to remove from the current Navigation Route.
    ///
    public init(_ titleKey: LocalizedStringKey, amount: Int = 1) {
        self.label = Text(titleKey)
        self.pop = { $0.pop(amount) }
    }
    
    /// Creates a `PopView` that generates its label from a `String`.
    ///
    /// - Parameters:
    ///   - title: A `String` that describes what this `PopView` does.
    ///   - amount: The number of `Views` to remove from the current Navigation Route.
    ///
    public init<SomeString : StringProtocol>(_ title: SomeString, amount: Int = 1) {
        self.label = Text(title)
        self.pop = { $0.pop(amount) }
    }
    
    /// Creates a `PopView` that generates its label from a `LocalizedStringKey`
    ///
    /// - Parameters:
    ///   - titleKey: The key for this `PopView's` localized title, that describes what this `PopView` does.
    ///   - popType: The way this `PopView` will navigate backwards.
    ///
    public init(_ titleKey: LocalizedStringKey, popType: PopType = .pop(amount: 1)) {
        self.label = Text(titleKey)
        
        switch popType {
            case .pop(let amount): self.pop = { $0.pop(amount) }
            case .safePop(let amount): self.pop = { $0.safePop(amount) }
            case .toIndex(let index): self.pop = { $0.popTo(index) }
            case .last(let viewType): self.pop = { $0.popTo(viewType) }
            case .location(let navLocation): self.pop = { $0.popTo(navLocation) }
            case .wherePredicate(let predicate): self.pop = { $0.popToView(where: predicate) }
            case .root: self.pop = { $0.popToRoot() }
        }
    }
    
    /// Creates a `PopView` that generates its label from a `String`.
    ///
    /// - Parameters:
    ///   - title: A `String` that describes what this `PopView` does.
    ///   - popType: The way this `PopView` will navigate backwards.
    ///
    public init<SomeString : StringProtocol>(_ title: SomeString, popType: PopType = .pop(amount: 1)) {
        self.label = Text(title)
        
        switch popType {
            case .pop(let amount): self.pop = { $0.pop(amount) }
            case .safePop(let amount): self.pop = { $0.safePop(amount) }
            case .toIndex(let index): self.pop = { $0.popTo(index) }
            case .last(let viewType): self.pop = { $0.popTo(viewType) }
            case .location(let navLocation): self.pop = { $0.popTo(navLocation) }
            case .wherePredicate(let predicate): self.pop = { $0.popToView(where: predicate) }
            case .root: self.pop = { $0.popToRoot() }
        }
    }
}

