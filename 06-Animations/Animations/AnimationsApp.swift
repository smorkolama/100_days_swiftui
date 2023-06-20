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
        case gestures
        case hello
        case hide
        case pivot
    }

    @State private var selection: Tab = .pivot

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
                GesturesAnimationView()
                    .tabItem {
                        Label("Gestures", systemImage: "hand.wave")
                    }
                    .tag(Tab.gestures)
                HelloView()
                    .tabItem {
                        Label("Hello", systemImage: "hand.raised")
                    }
                    .tag(Tab.hello)
                HideView()
                    .tabItem {
                        Label("Hide", systemImage: "circle.dotted")
                    }
                    .tag(Tab.hide)
                PivotView()
                    .tabItem {
                        Label("Pivot", systemImage: "rotate.right")
                    }
                    .tag(Tab.pivot)
            }
        }
    }
}
