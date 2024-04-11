import SwiftUI

public struct MultipleChoiceQuestionView: View {
    let question: MultipleChoiceQuestion
    let action: ([SelectAnswer]) -> Void

    @State var selection: [SelectAnswer] = []
    @Environment(\.quizStyle) var style
    @Environment(\.dynamicTypeSize) var dynamic


    public init(question: MultipleChoiceQuestion, action: @escaping ([SelectAnswer]) -> Void) {
        self.question = question
        self.action = action
    }
    
    
    @ViewBuilder
    var answer: some View {
        
        Text("Select \(question.correctAnswers.count)")
            .font(.callout)
            .bold()
            .padding(.horizontal)
            .padding(.top, 4)
            .padding(.bottom)
            .opacity(0.6)
            
        ForEach(question.options, id: \.value) { option in
            AnswerCell(isSelected: selection.contains(option), answer: option, type: .multipleChoice) {
                withAnimation(style.toggleAnswerAnimation) {
                    if selection.contains(option) {
                        selection.removeAll { answer in
                            answer == option
                        }
                    } else {
                        selection.append(option)
                    }
                }
            }
            .padding(.trailing, 10)
            .padding(.leading, selection.contains(option) ? 20 : 10)
        }
    }
    
    
    public var body: some View {
        ScrollView {
            VStack(alignment: dynamic.isAccessibilitySize ? .center : .leading) {
                Text(question.content)
                    .font(.title).fontWeight(.semibold)
                    .padding()
                answer
            }
        }
        
        HStack {
            Spacer()
            Button(action: {
                if selection.count == question.correctAnswers.count {
                    action(selection)
                }
            }, label: {
                Text("Submit")
                    .foregroundStyle(selection.count != question.correctAnswers.count ? style.unselectedBorderColor : style.selectedPrimaryColor)
            })
            .disabled(selection.count != question.correctAnswers.count)
            .bold()
        }
        .padding(.vertical)
        .padding(.trailing, 24)
        
    }
}

#Preview {
    MultipleChoiceQuestionView(
        question: .init(
        id: .init(),
        content: "What is the answer to life and everything?",
        options: [
            .init(value: "Some long winded answer that really means nothing."),
            .init(value: "Some answer"),
            .init(value: "42"),
            .init(value: "cheese is good"),
        ],
        correctAnswers: [.init(value: "42")]

        )) { answer in
            
        }
        .environment(\.quizStyle, .init(unselectedPrimaryColor: .gray, selectedPrimaryColor: .red))

}

