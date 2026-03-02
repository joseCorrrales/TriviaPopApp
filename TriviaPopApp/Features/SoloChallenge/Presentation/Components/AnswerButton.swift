import SwiftUI
import Combine


struct AnswerButton: View {
    
    let bgImage: String = "answerBackground"
    let text: String
    let height: CGFloat
    let width: CGFloat
    let isCorrect: Bool
    
    let hasAnswered: Bool
    var action: (() -> Void)? = nil
    
    @State private var isPressed = false
    @State var result_image : Bool = true
    @State var isSelected: Bool = false
    
    private var answerImage: String {
        if isCorrect {
            return "quiz_check"
        } else if isSelected {
            return "quiz_error"
        }
        return ""
    }
    private var showResultImage: Bool {
        if !hasAnswered { return false }
        return isCorrect || isSelected
    }
    
    private var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
    }
    
    var body: some View {
        Button {
            isSelected = true
            action?()
        } label: {
            ZStack {
                Image(bgImage)
                    .resizable(resizingMode: .tile)
                    .allowsHitTesting(false)
                
                HStack {
                    AppTheme.TextStyle.question(text)
                }
                .padding(.horizontal, 10)
                ZStack (alignment:.center){
                    if !answerImage.isEmpty {
                        Image(answerImage)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .opacity(showResultImage ? 1 : 0)
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
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.black,
                              lineWidth: 10
                             )
        )
        .clipShape(shape)
    }
}

#Preview {
    VStack{
        AnswerButton(text: "Respuesta Correcta", height: 90, width: 350, isCorrect: true, hasAnswered: true)
        }.frame(width: 300, height: 90)
        
        
    }


