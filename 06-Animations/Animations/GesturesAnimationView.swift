//
//  GesturesAnimationView.swift
//  Animations
//
//  Created by Benjamin van den Hout on 20/06/2023.
//

import SwiftUI

struct GesturesAnimationView: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        print(dragAmount)

        return LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            )
    }
}

struct GesturesAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        GesturesAnimationView()
    }
}
