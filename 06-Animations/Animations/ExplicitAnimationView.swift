//
//  ExplicitAnimationView.swift
//  Animations
//
//  Created by Benjamin van den Hout on 20/06/2023.
//

import SwiftUI

struct ExplicitAnimationView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false

    var body: some View {
        VStack {
            Button("Tap Me 1") {
                // This triggers the rotation3DEffect
                //            withAnimation {
                //                animationAmount += 360
                //            }
                // more complex
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            
            Button("Tap Me 2") {
                enabled.toggle()
                
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.default, value: enabled) // needs to be at the back because otherwise only color animation works
            
            Button("Tap Me 3") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(.default, value: enabled)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
        }
    }

}

struct ExplicitAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimationView()
    }
}
