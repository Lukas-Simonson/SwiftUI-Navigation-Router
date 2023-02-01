//
//  PushView.swift
//  
//
//  Created by Lukas Simonson on 2/1/23.
//

import SwiftUI

public struct PushView<Label : View, Destination : View> : View {

    @NavRouter private var router
    private var label: Label
    private var destination: Destination
    
    public var body: some View {
        Button(action: push, label: { label })
    }
    
    public init(_ destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    private func push() {
        router.push(destination)
    }
}

extension PushView where Label == Text {
    public init(_ titleKey: LocalizedStringKey, destination: Destination) {
        self.destination = destination
        self.label = Text(titleKey)
    }
    
    public init<SomeString : StringProtocol>(_ title: SomeString, destination: Destination) {
        self.destination = destination
        self.label = Text(title)
    }
}
