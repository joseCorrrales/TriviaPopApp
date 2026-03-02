//
//  CategoryWheelView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import SwiftUI
import Combine


struct CategoryWheelView: View {
    @StateObject var viewModel: CategoryWheelViewModel
    
    @State private var pulse = false
    @State private var showResult = false
    @State private var categorieName = ""
    
    init(viewModel: CategoryWheelViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    private var star: some View {
        ZStack {
            
            Image(systemName: "star.fill")
                .font(.system(size: 300))
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.9), radius: 12)
                .scaleEffect(pulse ? 1.1 : 0.95)
                .animation(
                    .easeInOut(duration: 0.4)
                        .repeatForever(autoreverses: true),
                    value: pulse
                )
            Text(categorieName).font(.system(size: 26, weight: .heavy))
                .foregroundColor(.white)
                .shadow(radius: 4)
                .padding(.top,10)
        }
    }
 
    var body: some View {
        
        ZStack {
            VStack (alignment: .center){
                HStack{
                    bannerShowCard()
                }
                HStack{
                    WheelView(
                        slices: [
                            .init(color: .green,  icon: Image(systemName: "testtube.2"), value: "science"),
                            .init(color: .yellow, icon: Image(systemName: "football"), value: "ART"),
                            .init(color: .orange, icon: Image(systemName: "football"), value: "Sport"),
                            .init(color: .red,    icon: Image(systemName: "paintbrush.fill"), value: "entertainment"),
                            .init(color: .pink,   icon: Image(systemName: "cloud.sun.fill"), value: "famous"),
                        ],
                        onResult: { slice in
                            let category: Category = .init(id: 0, name: slice.value)
                            pulse = true
                            showResult = true
                            categorieName = category.name
                            
                            Task{
                                try? await Task.sleep(for: .seconds(1.2))
                                viewModel.pickCategory(category)
                            }
                        }
                    )
                }
                HStack  (alignment:.firstTextBaseline){
                    Image("starCategories")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250)
                        .frame(height: 40)
                        .offset(x:-15)
                    Spacer()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("wheel_background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                )
            
            
            star.opacity(showResult ? 1 : 0)
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct bannerShowCard : View {
    
    var body: some View {
        VStack
        {
            HStack (alignment: .center){
                ZStack {
                    Image("bannerShow")
                        .resizable()
                        .scaledToFit()
                    Text(String(localized: "category.name", table: "SoloChallenge"))
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.white)
                        .shadow(radius: 4)
                        .padding(.top,10)
                }
                .frame(width: 370)
                .clipped()
                
            }
        }
    }
}

#Preview {
    let appRouter = AppRouter()
    let viewModel = CategoryWheelViewModel(router: appRouter)
    CategoryWheelView(viewModel: viewModel)
}
