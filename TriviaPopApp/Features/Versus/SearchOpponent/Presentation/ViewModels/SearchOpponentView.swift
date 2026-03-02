//
//  SearchOpponentView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 7/2/26.
//

import SwiftUI

struct SearchOpponentView: View {
    
  

    @StateObject var viewModel: SearchOpponentViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Button("Buscar oponente") {
                    viewModel.startSearch()
                }

            case .authenticating:
                ProgressView("Conectando…")

            case .searching:
                ProgressView("Buscando oponente…")

            case .matched(let player):
                Text("Oponente: \(player.name)")

            case .failed(let message):
                Text("Error: \(message)")
            }
        }
    }
}
