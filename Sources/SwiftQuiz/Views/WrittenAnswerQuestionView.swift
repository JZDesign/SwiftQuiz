import SwiftUI

public struct WrittenAnswerQuestionView: View {
    let style: Style
    let question: WrittenResponseQuestion
    let action: (String) -> Void

    public init(style: Style, question: WrittenResponseQuestion, action: @escaping (String) -> Void) {
        self.style = style
        self.question = question
        self.action = action
    }
    
    @State var answer = ""
    @FocusState var isFocused

    public var body: some View {
        ScrollView {
            VStack {
                Text(question.content)
                    .font(.title).fontWeight(.semibold)
                    .padding(.horizontal)
                
                if question.type == .short {
                    TextField("Answer", text: $answer)
                        .textFieldStyle(.plain)
                        .tint(style.selectedIndicatorColor)
                        .focused($isFocused)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerSize: .init(width: style.cornerRadius, height: style.cornerRadius))
                                .stroke(isFocused ? style.selectedBorderColor : style.unselectedBorderColor, lineWidth: 2)
                                .padding(4)
                        )
                } else {
                    ZStack {
                        TextEditor(text: $answer)
                            .tint(style.selectedIndicatorColor)
                            .focused($isFocused)
                        Text(answer)
                            .opacity(0)
                            .frame(minHeight: 150)
                            .padding()
                    }
                    .cornerRadius(style.cornerRadius)
                    .shadow(color: isFocused ? style.selectedBorderColor : .primary, radius: 1)
                    .padding()
                }
            }
        }
        
        HStack {
            Spacer()
            Button(action: {
                isFocused = false
                if !answer.isEmpty {
                    action(answer)
                }
            }, label: {
                Text("Submit")
            })
            .disabled(answer.isEmpty)
            .bold()
        }
        .padding(.vertical)
        .padding(.trailing, 24)
        
    }
}


#Preview {
    WrittenAnswerQuestionView(
        style: .init(unselectedIndicatorColor: .gray, selectedIndicatorColor: .red),
        question: .init(
            id: .init(),
            content: "What is the answer to life and everything?",
            type: .long
        )
    ) { _ in }
}
