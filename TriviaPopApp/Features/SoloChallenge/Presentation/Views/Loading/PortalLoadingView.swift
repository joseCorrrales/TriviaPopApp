//
//  PortalLoadingView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import SwiftUI

struct PortalLoadingView: View {
    
    @StateObject private var viewModel: PortalLoadingViewModel
    @State private var progress: CGFloat = 0
    @State private var currentX: CGFloat = 20
    @State private var currentY: CGFloat = 140
    @State private var handMove: CGFloat = 0
    @State private var writtenWords: [CGPoint] = []
    @State private var timer: Timer?
    
    private let horizontalSpacing: CGFloat = 30
    private let verticalSpacing: CGFloat = 70
    private let writingSpeed: CGFloat = 0.012
    
    private let imageWidth: CGFloat = 320
    private let imageHeight: CGFloat = 90
    
    
    private let paddinStartchalkX: CGFloat = 20
    private let paddinStartchalkY: CGFloat = 60
    
    init(viewModel: PortalLoadingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    
    var body: some View {
        
        
        GeometryReader { geo in
            
            ZStack(alignment: .topLeading) {
                
                Color(red: 0.08, green: 0.18, blue: 0.15)
                    .ignoresSafeArea()
                
                ForEach(0..<writtenWords.count, id: \.self) { index in
                    Image("loading_chalk")
                        .resizable()
                        .frame(width: imageWidth, height: imageHeight)
                        .position(
                            x: writtenWords[index].x + imageWidth/2,
                            y: writtenWords[index].y
                        )
                }
                
                Image("loading_chalk")
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
                    .mask(
                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: imageWidth * progress)
                            Spacer(minLength: 0)
                        }
                    )
                    .position(
                        x: currentX + imageWidth/2,
                        y: currentY
                    )
                Image("start_chalk")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .position(
                        x: paddinStartchalkX + imageWidth * progress,
                        y: paddinStartchalkY + currentY + handMove
                    )
            }
            .task {
                await viewModel.start()
            }
            .onAppear {
                startLoop(in: geo.size)
            }
            .onDisappear() {
                stopLoop()
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}

extension PortalLoadingView {
    
    private func startLoop(in size: CGSize) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { timer in
            
            progress += writingSpeed
            
            handMove = CGFloat.random(in: 0.1 ... 1.2)
            
            if progress >= 1 {
                writtenWords.append(CGPoint(x: currentX, y: currentY))
                
                progress = 0
                currentX += imageWidth + horizontalSpacing
                
                if currentX + imageWidth > size.width {
                    currentX = paddinStartchalkX
                    currentY += verticalSpacing
                    if currentY > size.height - 80 {
                        writtenWords.removeAll()
                        currentY = 140
                    }
                }
            }
        }
    }
    
    private func stopLoop() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    let router = AppRouter()
    let vm = PortalLoadingViewModel(router:router, category: Category.init(id: 0, name: "hola)"))
    PortalLoadingView(viewModel: vm)
    
}





