import SwiftUI


// TODO: Consolidate this with the other multi select view
public struct MultipleSelectSurveyQuestionView: View {
    let question: MultiSelectSurveyQuestion
    let action: ([SelectAnswer]) -> Void

    @State var selection: [SelectAnswer] = []
    @Environment(\.quizStyle) var style
    @Environment(\.dynamicTypeSize) var dynamic


    public init(question: MultiSelectSurveyQuestion, action: @escaping ([SelectAnswer]) -> Void) {
        self.question = question
        self.action = action
    }
    
    
    @ViewBuilder
    var answer: some View {
        Text("Select \(question.selectAtLeast) to \(question.selectAtMost)")
            .font(.callout)
            .bold()
            .padding(.horizontal)
            .padding(.top, 4)
            .padding(.bottom)
            .opacity(0.6)
            
        ForEach(question.options, id: \.value) { option in
            AnswerCell(isSelected: selection.contains(option), answer: option, type: .multipleChoice) {
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
    
    
    public var body: some View {
        ScrollView {
            VStack(alignment: dynamic.isAccessibilitySize ? .center : .leading) {
                Text(question.content)
                    .font(.title).fontWeight(.semibold)
                    .padding(.horizontal)
                answer
            }
        }
        
        HStack {
            Spacer()
            Button(action: {
                if (question.selectAtLeast...question.selectAtMost).contains(UInt(selection.count)) {
                    action(selection)
                }
            }, label: {
                Text("Submit")
                    .foregroundStyle(!(question.selectAtLeast...question.selectAtMost).contains(UInt(selection.count)) ? style.unselectedBorderColor : style.selectedPrimaryColor)
            })
            .disabled(!(question.selectAtLeast...question.selectAtMost).contains(UInt(selection.count)))
            .bold()
        }
        .padding(.vertical)
        .padding(.trailing, 24)
        
    }
}

#Preview {
    MultipleSelectSurveyQuestionView(
        question: .init(
        id: .init(),
        content: "What is the answer to life and everything?",
        options: [
            .init(value: "Some long winded answer that really means nothing."),
            .init(value: "Some answer"),
            .init(value: "42"),
            .init(value: "cheese is good"),
        ],
        selectAtLeast: 1,
        selectAtMost: 3

        )) { answer in
            
        }
        .environment(\.quizStyle, .init(unselectedPrimaryColor: .gray, selectedPrimaryColor: .red))

}

