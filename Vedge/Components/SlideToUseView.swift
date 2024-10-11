import SwiftUI
import Lottie


struct SlideToUseView: View {
    @EnvironmentObject var nfcManager: NFCSessionManager
    @Binding var showingNFCView: Bool
    @State private var buttonWidth: CGFloat = 64 // 초기 버튼 너비
    @Binding var foregroundColor: Color
    @State private var isDragging = false
    @State private var finishDragging = false
    @State private var lottieColor: ColorValueProvider = ColorValueProvider(LottieColor(r: 1, g: 0, b: 0, a: 1))
    
    let animation = LottieAnimation.named("PhaseCheck")

    let keypath = AnimationKeypath(keypath: "**.Color")


    let maxButtonWidth: CGFloat = UIScreen.main.bounds.width - 40 // 좌우 패딩을 고려하여 조정
    
    private var textOpacity: CGFloat {
        let progress = (buttonWidth - 64) / (maxButtonWidth - 64)
        return 1 - progress
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            // 배경
            RoundedRectangle(cornerRadius: 36)
                .fill(Constants.VariableBackgroundComponent)
                .frame(height: 72)
            
            // 텍스트
            Text("밀어서 사용하기")
                .textStyle(.body, accent: false, color: Constants.TextVariableAlternative)
                .frame(maxWidth: .infinity, alignment: .center)
                .opacity(textOpacity)
            
            // 드래그 가능한 버튼
            HStack {
                if(finishDragging) {
                    LottieView(animation: animation)
                        .playing()
                        .valueProvider(lottieColor, for: keypath)
                        .animationDidFinish{ _ in
                            showingNFCView = true
                            nfcManager.startNFCSession()
                        }
                    
                } else {
                    Image("Ticket")
                        .frame(width: 32, height: 32)
                        .foregroundColor(foregroundColor)
                }
            }
            .frame(width: buttonWidth, height: 64)
            .background(Constants.FixedBackgoundWhite)
            .cornerRadius(1000)
            .padding(.leading, 4) // 왼쪽 패딩 추가
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        buttonWidth = min(max(64, 64 + value.translation.width), maxButtonWidth)
                    }
                    .onEnded { _ in
                        isDragging = false
                        finishDragging = true
                    }
            )
        }
        .padding(16) // 전체 뷰에 패딩 추가
        .frame(maxWidth: .infinity)
        .frame(height: 80) // 전체 높이 설정
        .onAppear() {
            lottieColor = ColorValueProvider(foregroundColor.lottieColorValue)
        }
    }
}
