//
//  AttachedAnimationView.swift
//  Animations
//
//  Created by Benjamin van den Hout on 19/06/2023.
//

import SwiftUI

struct AttachedAnimationView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
//        .scaleEffect(animationAmount)

        // A radius of (animationAmount - 1) * 3 means the blur radius will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.
//        .blur(radius: (animationAmount - 1) * 3)

        // create an implicit animation for our changes so that all the scaling happens smoothly by adding an animation() modifier to the button:
//        .animation(.default, value: animationAmount)

        // There are even spring animations, that cause the movement to overshoot then return to settle at its target. You can control the initial stiffness of the spring (which sets its initial velocity when the animation starts), and also how fast the animation should be “damped” – lower values cause the spring to bounce back and forth for longer.
//        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)

        // ease-in-out animation that lasts for two seconds
//        .animation(.easeInOut(duration: 2), value: animationAmount)

        // repeat a certain number of times, and even make it bounce back and forward by setting autoreverses to true. This creates a one-second animation that will bounce up and down before reaching its final size:
//        .animation(
//            .easeInOut(duration: 1)
//                .repeatCount(3, autoreverses: true),
//            value: animationAmount)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .animation(.default, value: animationAmount)
        .onAppear {
            // This kicks of the animation around the button
            animationAmount = 2
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AttachedAnimationView()
    }
}
