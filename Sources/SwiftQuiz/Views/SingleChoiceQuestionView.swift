import SwiftUI

struct SingleChoiceQuestionView: View {
    let style: Style
    let question: SingleChoiceQuestion
    @State var selection: Answer?
    let action: (Answer) -> Void
    
    @ViewBuilder
    var answer: some View {
        ForEach(question.options) { option in
            AnswerCell(isSelected: selection == option, answer: option, type: .singleCoice, style: style) {
                withAnimation(.snappy(extraBounce: 0.5)) {
                    selection = option
                }
            }
            .padding(.trailing, 10)
            .padding(.leading, selection == option ? 20 : 10)
        }
    }
    
    var body: some View {
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
        style: .init(unselectedIndicatorColor: .gray, selectedIndicatorColor: .red),
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
}

//Text("Select \(multipleChoiceQuestion.correctAnswers.count)")
//    .font(.callout)
//    .padding()
//ForEach(multipleChoiceQuestion.options) { option in
//    AnswerCell(isSelected: selections.contains(option), answer: option, type: .multipleChoice) {
//        if selections.contains(option) {
//            selections.removeAll { answer in
//                answer == option
//            }
//        } else {
//            selections.append(option)
//        }
//    }
//}
