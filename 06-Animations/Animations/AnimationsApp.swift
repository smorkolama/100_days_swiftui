//
//  AnimationsApp.swift
//  Animations
//
//  Created by Benjamin van den Hout on 19/06/2023.
//

import SwiftUI

@main
struct AnimationsApp: App {
    enum Tab {
        case attached
        case binding
        case explicit
    }

    @State private var selection: Tab = .explicit

    var body: some Scene {

        WindowGroup {
            TabView(selection: $selection) {
                AttachedAnimationView()
                    .tabItem {
                        Label("Attached", systemImage: "button.programmable")
                    }
                    .tag(Tab.attached)
                BindingAnimationView()
                    .tabItem {
                        Label("Binding", systemImage: "pencil")
                    }
                    .tag(Tab.binding)
                ExplicitAnimationView()
                    .tabItem {
                        Label("Explicit", systemImage: "exclamationmark.triangle")
                    }
                    .tag(Tab.explicit)
            }
        }
    }
}
