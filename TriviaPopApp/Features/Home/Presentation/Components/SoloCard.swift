//
//  Untitled.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 10/2/26.
//

import SwiftUI


struct SoloCard: View {
    
    let height: CGFloat
    let width: CGFloat
    var action: (() -> Void)? = nil
    
    @State private var isPressed = false
    
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                Image("Home/soloMode")
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 0) {
                    
                    HStack(spacing: 12) {
                        Image("Home/star")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 60)
                            .offset(y: -12)
                        
                        VStack(alignment: .center , spacing: 10) {
                            Text(String(localized: "button.challenge", table: "Home"))
                                .font(.system(size: 22, weight: .heavy, design: .rounded))
                                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 3)
                                .foregroundStyle(.white)
                            Text(String(localized: "button.versus", table: "Home"))
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                                .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 3)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
        .frame(width: width, height: height)
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.96 : 1)
        .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}


#Preview {
    VStack{
        
        
        SoloCard( height: 300
                  ,width: 400) {
            print("Botón presionado")
        }
    }
}


