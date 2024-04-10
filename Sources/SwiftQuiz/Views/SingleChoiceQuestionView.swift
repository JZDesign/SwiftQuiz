import SwiftUI

public struct SingleChoiceQuestionView: View {
    let question: SingleChoiceQuestion
    let action: (Answer) -> Void
    
    @State var selection: Answer?
    @Environment(\.quizStyle) var style
    
    public init(question: SingleChoiceQuestion, action: @escaping (Answer) -> Void) {
        self.question = question
        self.action = action
    }
    
    @ViewBuilder
    var answer: some View {
        ForEach(question.options) { option in
            AnswerCell(isSelected: selection == option, answer: option, type: .singleCoice) {
                withAnimation(.snappy(extraBounce: 0.5)) {
                    selection = option
                }
            }
            .padding(.trailing, 10)
            .padding(.leading, selection == option ? 20 : 10)
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                Text(question.content)
                    .font(.title).fontWeight(.semibold)
                    .padding()
                answer
            }
        }
        
        HStack {
            Spacer()
            Button(action: {
                if let selection {
                    action(selection)
                }
            }, label: {
                Text("Submit")
            })
            .disabled(selection == nil)
            .bold()
        }
        .padding(.vertical)
        .padding(.trailing, 24)
        
    }
}

#Preview {
    SingleChoiceQuestionView(
        question: .init(
        id: .init(),
        content: "What is the answer to life and everything?",
        options: [
            .init(id: .init(), value: "Some long winded answer that really means nothing."),
            .init(id: .init(), value: "Some answer"),
            .init(id: .init(), value: "42"),
            .init(id: .init(), value: "cheese is good"),
        ],
        correctAnswer: .init(id: .init(), value: "42")

        )) { answer in
            
        }
        .environment(\.quizStyle, .init(unselectedIndicatorColor: .gray, selectedIndicatorColor: .red))
}
