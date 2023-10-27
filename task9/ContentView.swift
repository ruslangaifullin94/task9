//
//  ContentView.swift
//  task9
//
//  Created by Руслан Гайфуллин on 27.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var offSet: CGSize = .zero
    
    private var point: CGPoint {
        CGPoint(x: UIScreen.main.bounds.width / 2.0,y: UIScreen.main.bounds.height / 2.0)
    }
    
    var body: some View {
        Canvas { context, size in
            let shapeOne = context.resolveSymbol(id: 1)!
            let shapeTwo = context.resolveSymbol(id: 2)!
            
            context.addFilter(.alphaThreshold(min: 0.5, color:.blue))
            
            context.addFilter(.blur(radius: 25))
            
            context.drawLayer { context in
                context.draw(shapeOne, at: point)
                context.draw(shapeTwo, at: point)
            }
        } symbols: {
            Ellipse()
                .frame(width: 200, height: 200)
                .tag(1)
            Ellipse()
                .frame(width: 200, height: 200)
                .offset(x: offSet.width, y: offSet.height)
                .tag(2)
        }
        .ignoresSafeArea()
        .gesture(DragGesture()
            .onChanged { value in
                offSet = value.translation
            }.onEnded { value in
                withAnimation(.spring(bounce: 0.3)) {
                    offSet = .zero
                }
            })
    }
}


#Preview {
    ContentView()
}
