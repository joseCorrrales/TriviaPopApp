import SwiftUI


struct HomeCardButton: View {
    
    let bgImage: String
    let text: String
    let height: CGFloat
    let width: CGFloat
    var action: (() -> Void)? = nil
    
    @State private var isPressed = false
    
    
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                Image(bgImage)
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 0) {
                    
                    HStack(spacing: 12) {
                        Image("Home/control")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 60)
                            .offset(y: -15)
                            .rotationEffect(.degrees(10))
                       
                        
                        
                        Text("1 vs 1")
                            .font(.system(size: 42, weight: .heavy, design: .rounded))
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 3)
                            .foregroundStyle(.white)
    
                        Image("Home/control")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 60)
                            .offset(y: 6)
                            .rotationEffect(.degrees(10))
                    }
                    .padding( 0)
                    
                    
                    HStack(alignment: .center) {
                        Text(String(localized: "button.playervsplayer", table: "Home"))
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 3)
                            .foregroundStyle(.white)
                            
                    }

                }
                
            }
        }
        .frame(width: width, height: height)
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.96 : 1)
        .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
    
}


#Preview {
    VStack{
        
        
        HomeCardButton(bgImage: "Home/versusMode",text: "Correct 11", height: 300
                       ,width: 400) {
            print("Botón presionado")
        }
    }
}
