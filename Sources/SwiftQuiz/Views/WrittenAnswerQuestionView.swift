import SwiftUI

public struct WrittenAnswerQuestionView: View {
    let question: WrittenResponseQuestion
    let action: (String) -> Void

    public init(question: WrittenResponseQuestion, action: @escaping (String) -> Void) {
        self.question = question
        self.action = action
    }
    
    @Environment(\.quizStyle) var style
    @State var answer = ""
    @FocusState var isFocused

    public var body: some View {
        ScrollView {
            VStack {
                Text(question.content)
                    .font(.title).fontWeight(.semibold)
                    .padding()
                
                if question.type == .short {
                    TextField("Answer", text: $answer)
                        .textFieldStyle(.plain)
                        .tint(style.selectedPrimaryColor)
                        .focused($isFocused)
                        .padding()
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerSize: .init(width: style.cornerRadius, height: style.cornerRadius))
                                .stroke(isFocused ? style.selectedBorderColor : style.unselectedBorderColor, lineWidth: 2)
                                .padding(4)
                                .padding(.horizontal)
                        )
                } else {
                    ZStack {
                        TextEditor(text: $answer)
                            .tint(style.selectedPrimaryColor)
                            .focused($isFocused)
                        Text(answer)
                            .opacity(0)
                            .frame(minHeight: 150)
                            .padding()
                    }
                    .cornerRadius(style.cornerRadius)
                    .padding()
                    .shadow(color: isFocused ? style.selectedBorderColor : .primary, radius: 1)
                    .onAppear {
                        if answer == "" {
                            answer = "\n" // add some interior padding for mac
                        }
                    }
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
                    .foregroundStyle(answer.isEmpty ? style.unselectedBorderColor : style.selectedPrimaryColor)
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
        question: .init(
            id: .init(),
            content: "What is the answer to life, the universe, and everything?",
            type: .short
        )
    ) { _ in }
        .environment(\.quizStyle, .init(unselectedPrimaryColor: .gray, selectedPrimaryColor: .red))
}
