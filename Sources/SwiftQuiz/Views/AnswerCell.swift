import SwiftUI

public struct AnswerCell: View {
    let isSelected: Bool
    let answer: SelectAnswer
    let type: ChoiceType
    
    let onTap: () -> Void
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.quizStyle) var style

    
    public init(
        isSelected: Bool,
        answer: SelectAnswer,
        type: ChoiceType,
        onTap: @escaping () -> Void
    ) {
        self.isSelected = isSelected
        self.answer = answer
        self.type = type
        self.onTap = onTap
    }
    
    var filledImage: Image {
        switch type {
        case .singleCoice:
            return Image(systemName: "checkmark.circle.fill")
        case .multipleChoice:
            return Image(systemName: "checkmark.square.fill")
        }
    }
    
    var emptyImage: Image {
        switch type {
        case .singleCoice:
            return Image(systemName: "circle")
        case .multipleChoice:
            return Image(systemName: "square")
        }
    }

    @ViewBuilder
    var selectionIndicator: some View {
        emptyImage
            .overlay {
                filledImage
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(isSelected ? style.selectedPrimaryColor : style.unselectedPrimaryColor)
        
    }
    
    public var body: some View {
        Button(action: {
            onTap()
        }, label: {
            RStack {
                selectionIndicator
                    .padding(2)
                Text(answer.value)
                    .multilineTextAlignment(dynamicTypeSize.isAccessibilitySize ? .center : .leading)
            }
            .contentShape(Rectangle())
            .frame(maxWidth: style.shouldFillHorizontalSpace ? .infinity : nil)
            .padding()
            .background(content: {
                RoundedRectangle(cornerSize: CGSize(width: style.cornerRadius, height: style.cornerRadius))
                    .stroke(isSelected ? style.selectedBorderColor : style.unselectedBorderColor, lineWidth: dynamicTypeSize.isAccessibilitySize ? 4 : 2)
                    
            })
        }).buttonStyle(.plain)
    }
    
    public enum ChoiceType {
        case singleCoice, multipleChoice
    }
}


#Preview {
    ScrollView {
        VStack {
            AnswerCell(isSelected: false, answer: .init(value: "This is a sample answer"), type: .singleCoice) {}
                .foregroundStyle(Color.indigo)
                .environment(\.quizStyle, .init(shouldFillHorizontalSpace: false))
            AnswerCell(isSelected: false, answer: .init(value: "This is a sample answer"), type: .multipleChoice) {}
                .environment(\.quizStyle, .init(cornerRadius: 100))
            AnswerCell(isSelected: true, answer: .init(value: "This is a sample answer"), type: .singleCoice) {}
                .environment(\.quizStyle, .init(unselectedPrimaryColor: .gray, selectedPrimaryColor: .blue))
            AnswerCell(isSelected: true, answer: .init(value: "This is a sample answer"), type: .multipleChoice) {}
                .environment(\.quizStyle, .init(selectedPrimaryColor: .indigo))
                // Add custom Background
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                // End custom background
                .foregroundColor(.indigo)
                .bold()
        }
        .padding()
    }
}

