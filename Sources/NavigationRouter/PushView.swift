//
//  PushView.swift
//  
//
//  Created by Lukas Simonson on 2/1/23.
//

import SwiftUI

/// A `Button` that adds a `View` to the current Navigation Route.
public struct PushView<Label : View, Destination : View> : View {

    /// Gives access to the current Navigation Route.
    @NavRouter private var router
    
    /// The label to display.
    private var label: Label
    
    /// The destination to navigate to.
    private var destination: Destination
    
    public var body: some View {
        Button(action: push, label: { label })
    }
    
    /// Creates a `PushView` that displays a custom label.
    ///
    /// - Parameters:
    ///   - destination: The `View` to navigate to when the user triggers this `PushView`.
    ///   - label: A `View` that describes where this button will navigate to.
    ///
    public init(_ destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    /// Pushes this `PushView's` destination onto the current Navigation Route.
    private func push() {
        router.push(destination)
    }
}

extension PushView where Label == Text {
    
    /// Creates a `PushView` that generates its label from a `LocalizedStringKey`
    ///
    /// - Parameters:
    ///   - titleKey: The key for this `PushView's` localized title, that describes where this `PushView` navigates to.
    ///   - destination: A `View` to navigate to when the user triggers this `PushView`
    ///
    public init(_ titleKey: LocalizedStringKey, destination: Destination) {
        self.destination = destination
        self.label = Text(titleKey)
    }
    
    /// Creates a `PushView` that generates its label from a `String`.
    ///
    /// - Parameters:
    ///   - title: A `String` that describes where this `PushView` navigates to.
    ///   - destination: A `View` to navigate to when the suer triggers this `PushView`
    ///
    public init<SomeString : StringProtocol>(_ title: SomeString, destination: Destination) {
        self.destination = destination
        self.label = Text(title)
    }
}
