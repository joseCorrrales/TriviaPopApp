import SwiftUI
import Combine

struct CategoryStarCelebration: View {
    
    let category: String
    
    private let orbitDuration: Double = 2

    @State private var angle: Double = 0
    @State private var radius: CGFloat = 120
    @State private var showText = false
    @State private var textScale: CGFloat = 0.5
    @State private var pulse = false
    
    @State private var startDate: Date?
    @State private var orbiting = true
    
    var body: some View {
        GeometryReader { geo in
            
            let centerX = geo.size.width / 2
            let centerY = geo.size.height / 2
            
            ZStack {
                
                
                star
                    .position(
                        x: centerX + cos(angle) * radius,
                        y: centerY + sin(angle) * radius
                    )
            }
            .onAppear {
                startOrbit()
            }
            .onReceive(Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()) { _ in
                updateOrbit()
            }
        }
    }
    
    // MARK: - Star
    
    private var star: some View {
        ZStack {
            
            Image(systemName: "star.fill")
                .font(.system(size: 390))
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.9), radius: 12)
                .scaleEffect(pulse ? 1.1 : 0.95)
                .animation(
                    .easeInOut(duration: 0.4)
                        .repeatForever(autoreverses: true),
                    value: pulse
                )
            Text("asdasda")
        }
    }
    
    // MARK: - Orbit Logic
    
    private func startOrbit() {
        pulse = true
        startDate = Date()
    }
    
    private func updateOrbit() {
        guard orbiting, let startDate else { return }
        
        let elapsed = Date().timeIntervalSince(startDate)
        
        if elapsed < orbitDuration {
            let progress = elapsed / orbitDuration
            angle = progress * (.pi * 9) // 2 vueltas reales
            radius = radius - progress
        } else {
            orbiting = false
            radius = 0
            
        }
    }
}

#Preview{
    CategoryStarCelebration(category: "Historia")
    
    
    

}
