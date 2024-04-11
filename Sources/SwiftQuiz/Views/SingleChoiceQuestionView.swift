import SwiftUI

public struct SingleChoiceQuestionView: View {
    let question: SingleChoiceQuestion
    let action: (SelectAnswer) -> Void
    
    @State var selection: SelectAnswer?
    @Environment(\.quizStyle) var style
    
    public init(question: SingleChoiceQuestion, action: @escaping (SelectAnswer) -> Void) {
        self.question = question
        self.action = action
    }
    
    @ViewBuilder
    var answer: some View {
        ForEach(question.options, id: \.value) { option in
            AnswerCell(isSelected: selection == option, answer: option, type: .singleCoice) {
                withAnimation(style.toggleAnswerAnimation) {
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
                    .foregroundStyle(selection == nil ? style.unselectedBorderColor : style.selectedPrimaryColor)
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
            .init(value: "Some long winded answer that really means nothing."),
            .init(value: "Some answer"),
            .init(value: "42"),
            .init(value: "cheese is good"),
        ],
        correctAnswer: .init(value: "42")

        )) { answer in
            
        }
        .environment(\.quizStyle, .init(unselectedPrimaryColor: .gray, selectedPrimaryColor: .red))
}
