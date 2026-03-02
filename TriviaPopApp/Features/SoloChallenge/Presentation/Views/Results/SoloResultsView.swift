//
//  SoloResultsView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import SwiftUI
import Combine

struct SoloResultsView: View {
    
    @StateObject private var viewModel: SoloResultsViewModel
    
    init(viewModel: SoloResultsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ZStack (alignment:.top) {
            Image("result_background")
                .resizable()
                
                .ignoresSafeArea()
                
            
            VStack(spacing: 16) {
    
                VStack {
              
                    TitleCardView()
                    
                    CorrectButton(bgImage: "correct_box_bg",text:  String(localized: "result.correct", table: "SoloChallenge") + ": \(viewModel.result.incorrect)", height: 110,width: 350) {
                     
                    }
                    CorrectButton(bgImage: "incorrect_box_bg",text:  String(localized: "result.incorrect", table: "SoloChallenge") + ": \(viewModel.result.correct)", height: 100,width: 355) {
                       
                    }
                    Spacer()
                }
                VStack  {
                   
                    CorrectButton(bgImage: "playagain_box_bg",text: "Play again", height: 100,width: 300) {
                        Task{
                         await viewModel.start()
                        }
                    }
                    
                }
            }.padding(.top, 46)
                .padding(.horizontal, 16)
            
        }.navigationBarBackButtonHidden(true)
    }
    
    private struct TitleCardView: View {
        
        var body: some View {
            VStack(spacing: 16) {
                
                //String(localized: "category.name", table: "SoloChallenge")
                //"Resultado de la partida"
                //"¡Buen trabajo!"
                //String(localized: "category.name", table: "SoloChallenge")
                AppTheme.TextStyle.resultTitle(String(localized: "result.title", table: "SoloChallenge"))
                AppTheme.TextStyle.resultSubTitle(String(localized: "result.subtitle", table: "SoloChallenge"))
                
                
            }
        }
    }
}

#Preview {
    let router = AppRouter()
    let result = GameResult(correct: 10, incorrect: 10)
    let vm = SoloResultsViewModel(router: router, result: result)
    SoloResultsView(viewModel: vm)
}

