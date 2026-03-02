import SwiftUI


struct CorrectButton: View {
    
    let bgImage: String
    let text: String
    let height: CGFloat
    let width: CGFloat
    var action: (() -> Void)? = nil
    
    @State private var isPressed = false
    
    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: height/2, style: .continuous)
    }

    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                Image(bgImage)
                    .resizable()
                    .scaledToFill()
                    .allowsHitTesting(false)
            
                HStack {
                    Text(text)
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 10)
                
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
        CorrectButton(bgImage: "incorrect_box_bg",text: "Correct 11", height: 90,width: 250) {
            print("Botón presionado")
        }.frame(width: 300, height: 90)
        
        CorrectButton(bgImage: "correct_box_bg",text: "Correct 11", height: 110,width: 300) {
            print("Botón presionado")
        }
        
        CorrectButton(bgImage: "aswerRed_box_bg",text: "Correct 11", height: 110,width: 300) {
            print("Botón presionado")
        }
        
        CorrectButton(bgImage: "Home/Solomode",text: "Correct 11", height: 20,width: 200) {
            print("Botón presionado")
        }
    }
}
