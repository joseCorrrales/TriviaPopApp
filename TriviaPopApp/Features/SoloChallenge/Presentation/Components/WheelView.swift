import SwiftUI
import UIKit

struct WheelView: View {
    
    // MARK: - Public API
    struct Slice: Identifiable {
        let id = UUID()
        let color: Color
        let icon: Image
        let value: String
        
        init(color: Color, icon: Image, value: String) {
            self.color = color
            self.icon = icon
            self.value = value
        }
    }
    
    let slices: [Slice]
    var onResult: ((Slice) -> Void)? = nil
    
    // MARK: - Tuning
    private let spinDuration: Double = 3.0
    private let minRotations: Int = 5
    private let maxRotations: Int = 8
    
    // MARK: - State
    @State private var rotation: Double = 360
    @State private var isSpinning: Bool = false
    
    // Tick haptic
    @State private var tickTimer: Timer? = nil
    @State private var lastTickIndex: Int = -1
    
    init(slices: [Slice], onResult: ((Slice) -> Void)? = nil) {
        precondition(slices.count >= 2, "La ruleta necesita mínimo 2 casillas.")
        self.slices = slices
        self.onResult = onResult
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                wheelCanvas
                    .frame(width: 400, height: 400)
                    .rotationEffect(.degrees(rotation))
                
                pointerBadge
                    .offset(y: -198)
                
                centerSpinButton
            }
        }
        .padding()
        .onDisappear {
            tickTimer?.invalidate()
            tickTimer = nil
        }
    }
    
    // MARK: - Wheel (NO ForEach: Canvas dibuja todo)
    private var wheelCanvas: some View {
        Canvas { context, size in
            let n = slices.count
            let w = size.width
            let h = size.height
            let center = CGPoint(x: w / 2, y: h / 2)
            let radius = min(w, h) / 2
            
            
            let outerRingStroke: CGFloat = 6
            let innerRingInset: CGFloat = 16
            let sliceInset: CGFloat = 24
            
            
            let outerRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2)
            let outerCircle = Path(ellipseIn: outerRect)
            context.fill(outerCircle, with: .linearGradient(
                .init(colors: [.red,.blue]), startPoint: CGPoint(x: 0, y: 0),
                endPoint: CGPoint(x: w, y: h)
            ))
            context.stroke(outerCircle, with: .color(.black.opacity(0.15)), lineWidth: outerRingStroke)
            
            // Inner glossy ring
            let glossyR = radius - innerRingInset
            let glossyRect = CGRect(x: center.x - glossyR, y: center.y - glossyR, width: glossyR * 2, height: glossyR * 2)
            let glossyCircle = Path(ellipseIn: glossyRect)
            context.fill(glossyCircle, with: .color(Color.white.opacity(0.18)))
            context.stroke(glossyCircle, with: .color(Color.white.opacity(0.35)), lineWidth: 2)
            let sliceR = radius - sliceInset
            let sliceDeg = 360.0 / Double(n)
            
            for i in 0..<n {
                let startDeg = Double(i) * sliceDeg
                let endDeg   = Double(i + 1) * sliceDeg
                
                
                var p = Path()
                p.move(to: center)
                p.addArc(center: center,
                         radius: sliceR,
                         startAngle: .degrees(startDeg),
                         endAngle: .degrees(endDeg),
                         clockwise: false)
                p.closeSubpath()
                
                
                context.fill(p, with: .color(slices[i].color.opacity(0.95)))
                context.stroke(p, with: .color(.black.opacity(0.15)), lineWidth: 2)
                
                
                context.fill(p, with: .color(Color.white.opacity(0.10)))
                
                
                let midDeg = startDeg + sliceDeg / 2
                let midRad = midDeg * .pi / 180.0
                let iconDistance = sliceR * 0.62
                
                let iconCenter = CGPoint(
                    x: center.x + cos(midRad) * iconDistance,
                    y: center.y + sin(midRad) * iconDistance
                )
                
                // Resolve & draw icon
                let resolved = context.resolve(slices[i].icon)
                let iconSize: CGFloat = 52
                let iconRect = CGRect(
                    x: iconCenter.x - iconSize/2,
                    y: iconCenter.y - iconSize/2,
                    width: iconSize,
                    height: iconSize
                )
                
                context.draw(resolved, in: iconRect)
            }
            
            
        }
        .shadow(color: .white, radius: 18, y: 10)
    }
    
    // MARK: - Center Button
    private var centerSpinButton: some View {
        Button { spin() }label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 116, height: 116)
                    .overlay(Circle().stroke(Color.black.opacity(0.10), lineWidth: 4))
                    .shadow(color: .black.opacity(0.18), radius: 12, y: 8)
                
                Text(String(localized: "Spin", table: "SoloChallenge"))
                
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .green, .yellow, .orange, .pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
        }
        .buttonStyle(.automatic)
        .disabled(isSpinning)
    }
    
    // MARK: - Pointer Badge
    private var pointerBadge: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.red.opacity(0.95))
                .frame(width: 86, height: 62)
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.black.opacity(0.18), lineWidth: 3)
                )
                .shadow(color: .black.opacity(0.22), radius: 10, y: 6)
            
            TriangleDown()
                .fill(Color.red.opacity(0.95))
                .frame(width: 22, height: 12)
                .offset(y: 34)
            
            Image(systemName: "star.fill")
                .font(.system(size: 30, weight: .heavy))
                .foregroundStyle(Color.yellow)
                .shadow(color: .black.opacity(0.22), radius: 6, y: 3)
        }
    }
    
    // MARK: - Spin Logic
    private func spin() {
        guard !isSpinning else { return }
        isSpinning = true
        
        let n = slices.count
        let sliceDeg = 360.0 / Double(n)
        
        let targetIndex = Int.random(in: 0..<n)
        let centerOfSlice = (Double(targetIndex) * sliceDeg) + (sliceDeg / 2)
        let base = 90.0 - centerOfSlice
        let normalizedBase = base.truncatingRemainder(dividingBy: 360)
        
        let fullRot = Int.random(in: minRotations...maxRotations)
        let delta = (Double(fullRot) * 360.0) + normalizedBase
        
        startTicking(sliceDegrees: sliceDeg)
        
        
        withAnimation(.easeIn(duration: 0.16)) { rotation -= 14 }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(.timingCurve(0.10, 0.92, 0.18, 1.0, duration: spinDuration)) {
                rotation += delta + 8
            }
        }
        
        // settle bounce
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16 + spinDuration) {
            withAnimation(.spring(response: 0.26, dampingFraction: 0.55)) {
                rotation -= 8
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16 + spinDuration + 0.30) {
            stopTicking()
            isSpinning = false
            let result = slices[targetIndex]
            onResult?(result)
        }
    }
    
    private func startTicking(sliceDegrees: Double) {
        lastTickIndex = -1
        tickTimer?.invalidate()
        
        tickTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            let angle = (rotation.truncatingRemainder(dividingBy: 360) + 360)
                .truncatingRemainder(dividingBy: 360)
            let pointerAngle = (angle + 90).truncatingRemainder(dividingBy: 360)
            let idx = Int(pointerAngle / sliceDegrees)
            
            if idx != lastTickIndex {
                lastTickIndex = idx
            }
        }
    }
    
    private func stopTicking() {
        tickTimer?.invalidate()
        tickTimer = nil
    }
    
    private struct TriangleDown: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    WheelView(
        slices: [
            .init(color: .green,  icon: Image(systemName: "testtube.2"), value: "CIENCIA"),
            .init(color: .yellow, icon: Image(systemName: "football"), value: "ARTE"),
            .init(color: .orange, icon: Image(systemName: "football"), value: "DEPORTE"),
            .init(color: .red,    icon: Image(systemName: "paintbrush.fill"), value: "ENTRET."),
            .init(color: .pink,   icon: Image(systemName: "cloud.sun.fill"), value: "CLIMA"),
            
        ]
    )
}
