//
//  HomeView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            
            Image("Home/home_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack() {
                
                Image("Home/home_logo_poppi")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 260)
                    .padding(.bottom,40)
                    .padding(.top,40)
      
                HomeCardButton(bgImage: "Home/versusMode",text: "Correct 11", height: 130
                               ,width: 400) {
                    viewModel.startVersus()
                }
                
                SoloCard( height: 130
                          ,width: 400) {
                    viewModel.startTrivia()
                }
                
                Spacer(minLength:70)
                ZStack (alignment:.bottom){
                    Image("Home/topics")
                        .resizable()
                        .scaledToFit()
                        .frame( height: 65)
                }
            }
        }
    }
}


