//
//  FloatingControlsView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 10/2/26.
//

import SwiftUI

struct FloatingControlsView: View {
    
    var actionHome: () -> Void
    @Binding var isMuted: Bool
    
    var body: some View {
        HStack {
           
            Button(action: actionHome) {
                Image(systemName: "house.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(.white.opacity(0.9))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isMuted.toggle()
                }
            }) {
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(.white.opacity(0.9))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)     
    }
}


#Preview {
    FloatingControlsView(actionHome: {}, isMuted: .constant(false))
}
