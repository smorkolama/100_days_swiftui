//
//  HideView.swift
//  Animations
//
//  Created by Benjamin van den Hout on 20/06/2023.
//

import SwiftUI

struct HideView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                // this controls the animation
//                    .transition(.scale)
                // different animations on insert and remove
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }

}

struct HideView_Previews: PreviewProvider {
    static var previews: some View {
        HideView()
    }
}
