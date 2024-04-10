import SwiftUI

struct MultipleChoiceQuestionView: View {
    let style: Style
    let question: MultipleChoiceQuestion
    @State var selection: [Answer] = []
    let action: ([Answer]) -> Void
    
    @ViewBuilder
    var answer: some View {
        
        Text("Select \(question.correctAnswers.count)")
            .font(.callout)
            .bold()
            .padding(.top, 4)
            .padding(.bottom)
            .opacity(0.6)
            
        ForEach(question.options) { option in
            AnswerCell(isSelected: selection.contains(option), answer: option, type: .multipleChoice, style: style) {
                withAnimation(.snappy(extraBounce: 0.5)) {
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
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text(question.content)
                    .font(.title).fontWeight(.semibold)
                    .padding(.horizontal)
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
        correctAnswers: [.init(id: .init(), value: "42")]

        )) { answer in
            
        }
}

