//
//  HomeView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import SwiftUI

struct SoloQuestionView: View {
    @StateObject var viewModel: SoloQuestionViewModel
    
    init(viewModel: SoloQuestionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Image("soloView_background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                //   TitleView(viewModel: viewModel)
                QuestionCardView(questionText: viewModel.question.prompt)
                AnswerBuilderCardView(viewModel: viewModel, question:viewModel.question).id(viewModel.question.id)
                Spacer()
            }
            .padding(.top,65)
            .padding(.horizontal, 16)
            
        }.navigationBarBackButtonHidden(true)
        
    }
}


private struct QuestionCardView: View {
    
    let questionText: String
    
    var body: some View {
        ZStack {
            Image("titleCardBackground")
                .resizable(resizingMode: .tile)
            VStack{
                VStack{
                    AppTheme.TextStyle.question(questionText)
                }.padding(.horizontal,12)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(
                    ImagePaint(image: Image("titleCardBorder"), scale: 0.5),
                    lineWidth: 10
                )
        )
        
        .frame( maxHeight: 150)
        .frame( maxWidth: 360)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}


private struct TitleView : View {
    let viewModel: SoloQuestionViewModel
    
    var body: some View {
        
        ZStack{
            SubTitleCardView(viewModel: viewModel)
            TitleBoxView(categoryText: viewModel.question.category.name)
                .offset(y: -50)
        }
    }
}

private struct TitleCardView : View {
    let categoryText: String
    
    var body: some View {
        VStack{
            ZStack{
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.35),
                        Color.black.opacity(0.15)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                Text(categoryText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame( maxHeight: 70)
            .frame( maxWidth: 350)
            .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
        }
        
    }
}

private struct TitleBoxView : View {
    let categoryText: String
    
    var body: some View {
        
        ZStack {
            Image("backgroundTitle")
                .resizable()
                .scaledToFill()
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .clipped()
            
            TitleCardView(categoryText: categoryText)
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .stroke(Color.black.opacity(0.2), lineWidth: 2)
                .shadow(color: .black.opacity(0.3), radius: 3)
        )
    }
}

private struct SubTitleCardView : View {
    let viewModel: SoloQuestionViewModel
    
    var body: some View {
        
        
        ZStack{
            Image("titleCardBaclground")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .clipped()
            
            VStack{
                
                Text("sasdasd")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
            }.frame( maxHeight: 80)
                .frame( maxWidth: 350)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.white.opacity(0.7), lineWidth: 2)
                        .shadow(color: Color.purple.opacity(0.3), radius: 3)
                )
        }
        
        .frame( maxHeight: 92)
        .frame( maxWidth: 360)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.purple.opacity(0.4), lineWidth: 3)
                .shadow(color: Color.purple.opacity(0.3), radius: 6)
        )
    }
}

#Preview("Home") {
    let router = AppRouter()
   /* let questionPack = QuestionPack(category: "CINE", ageRange: "10-24", language: "en", questions: [QuestionItem(id: "id", difficulty: "difficulty",question: " how is the weather today in paris or london and what is the temperaturetemperaturetemperaturetemperaturetemperaturetemperaturetemperature?" ,options: ["A","B","C","D"], correctIndex: 0, explanation: "")])*/
    
    
    let questionPack =    [Question(id: UUID(), prompt: "how is the weather today in paris or london and what is the temperaturetemperaturetemperaturetemperaturetemperaturetemperaturetemperature?", options: ["A","B","C","D"], correctIndex: 1, category: Category(id: 1, name: "CINE"), difficulty: Difficulty.easy)]
    
    
    let vm = SoloQuestionViewModel(router: router, listOfQuestions:  questionPack, index: 1, correct: 0, incorrect: 0)
    SoloQuestionView(viewModel: vm)
    
}

