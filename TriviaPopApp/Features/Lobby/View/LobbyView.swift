//
//  LobbyView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 2/3/26.
//

import SwiftUI
import Combine

struct LobbyView: View {
    
    @StateObject var viewModel : LobbyViewModel

    init(viewModel: LobbyViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
           List(viewModel.onlineUsers) { user in
               Text(user.name)
            }
            .navigationTitle("Player online")
            .task { await viewModel.startListening() }
        
            .onDisappear() {
                viewModel.onDisappear()
            }
    }
}
