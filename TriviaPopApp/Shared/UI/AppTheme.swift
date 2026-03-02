//
//  AppTheme.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import SwiftUI


enum AppTheme   {
    enum Radius {
        static let lg: CGFloat = 18
        static let xl: CGFloat = 24
    }
    
    enum Stroke {
        static let thin: CGFloat = 1
    }
    
    enum Opacity {
        static let stroke: CGFloat = 0.35
        static let shadow: CGFloat = 0.18
        static let pressed: CGFloat = 0.75
        static let disabled: CGFloat = 0.45
    }
    
    enum Shadow {
        static let y: CGFloat = 10
        static let blur: CGFloat = 18
    }
    
    enum Spacing {
        static let buttonV: CGFloat = 16
        static let buttonH: CGFloat = 18
    }
    
    enum Font {
        static let primaryCTA: SwiftUI.Font = .system(size: 22, weight: .heavy, design: .rounded)
        static let question: SwiftUI.Font = .system(size: 24, weight: .medium, design: .rounded)
        static let answer: SwiftUI.Font = .system(size: 26, weight: .bold, design: .rounded)
        
        static let resultTextLarge: SwiftUI.Font = .system(size: 54, weight: .medium, design: .rounded)
        static let resultText: SwiftUI.Font = .system(size: 34, weight: .medium, design: .rounded)
        
    }
    
    enum AppColor {
        static let questionText = Color(red: 0.95, green: 0.95, blue: 0.92)
        static let resultText = Color(red: 255/255, green: 198/255, blue: 46/255)
       
    }
    
    
    enum TextStyle {
        static func question(_ text: String) -> some View {
            Text(text)
                .foregroundStyle(AppTheme.AppColor.questionText)
                .multilineTextAlignment(.center)
                .font(.custom("ChalkboardSE-Bold", size: 26))
                    .shadow(color: .white.opacity(0.6), radius: 1)
                    .shadow(color: .white.opacity(0.4), radius: 2)
        }
        
            
        
        
        static func resultTitle(_ text: String) -> some View {
            Text(text)
               // .font(AppTheme.Font.resultText)
                .font(.custom("Avenir Next Rounded", size: 24))
                .fontWeight(.heavy)
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .shadow(color: .black.opacity(0.65), radius: 5, x: 0, y: 4)
                  .shadow(color: .black.opacity(0.20), radius: 4, x: 0, y: 8) 
                  .shadow(color: .white.opacity(0.25), radius: 3, x: 0, y: -1)
                  
        }
        
        static func resultSubTitle(_ text: String) -> some View {
            Text(text)
                .font(.custom("Avenir Next Rounded", size: 54))
                .foregroundStyle(AppTheme.AppColor.resultText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 4)
                  .shadow(color: .black.opacity(0.20), radius: 4, x: 0, y: 8)
                  .shadow(color: .white.opacity(0.25), radius: 3, x: 0, y: -1)
                  
        }
    }
}

#Preview {
    AppTheme.TextStyle.resultTitle("¡Buen trabajo!")
}
