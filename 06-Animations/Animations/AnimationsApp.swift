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
        case button
        case binding
    }

    @State private var selection: Tab = .binding

    var body: some Scene {

        WindowGroup {
            TabView(selection: $selection) {
                ContentView()
                    .tabItem {
                        Label("Button", systemImage: "button.programmable")
                    }
                    .tag(Tab.button)
                BindingView()
                    .tabItem {
                        Label("Binding", systemImage: "pencil")
                    }
                    .tag(Tab.binding)
            }
        }
    }
}
