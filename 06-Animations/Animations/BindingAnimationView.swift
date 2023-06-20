//
//  BindingAnimationView.swift
//  Animations
//
//  Created by Benjamin van den Hout on 20/06/2023.
//

import SwiftUI

struct BindingAnimationView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        print(animationAmount)
        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingAnimationView()
    }
}
