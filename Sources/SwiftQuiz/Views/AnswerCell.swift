import SwiftUI

public struct AnswerCell: View {
    let isSelected: Bool
    let answer: Answer
    let type: ChoiceType
    
    let unselectedIndicatorColor: Color
    let selectedIndicatorColor: Color
    
    let unselectedBorderColor: Color
    let selectedBorderColor: Color
    
    let cornerRadius: CGFloat
    let shouldFillHorizontalSpace: Bool
    
    let onTap: () -> Void
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    
    public init(
        isSelected: Bool,
        answer: Answer,
        type: ChoiceType,
        style: Style = .init(),
        onTap: @escaping () -> Void
    ) {
        self.isSelected = isSelected
        self.answer = answer
        self.type = type
        self.cornerRadius = style.cornerRadius
        self.shouldFillHorizontalSpace = style.shouldFillHorizontalSpace
        
        self.onTap = onTap
        
        self.unselectedIndicatorColor = style.unselectedIndicatorColor
        
        self.selectedIndicatorColor = style.selectedIndicatorColor
        
        self.unselectedBorderColor = style.unselectedBorderColor
        self.selectedBorderColor = style.selectedBorderColor
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
            .foregroundStyle(isSelected ? selectedIndicatorColor : unselectedIndicatorColor)
        
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
            .frame(maxWidth: shouldFillHorizontalSpace ? .infinity : nil)
            .padding()
            .background(content: {
                RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
                    .stroke(isSelected ? selectedBorderColor : unselectedBorderColor, lineWidth: dynamicTypeSize.isAccessibilitySize ? 4 : 2)
                    
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
            AnswerCell(isSelected: false, answer: .init(id: .init(), value: "This is a sample answer"), type: .singleCoice, style: .init(shouldFillHorizontalSpace: false)) {}
                .foregroundStyle(Color.indigo)
            AnswerCell(isSelected: false, answer: .init(id: .init(), value: "This is a sample answer"), type: .multipleChoice, style: .init(cornerRadius: 100)) {}
            AnswerCell(isSelected: true, answer: .init(id: .init(), value: "This is a sample answer"), type: .singleCoice, style: .init(unselectedIndicatorColor: .gray, selectedIndicatorColor: .blue)) {}
            AnswerCell(isSelected: true, answer: .init(id: .init(), value: "This is a sample answer"), type: .multipleChoice, style: .init(selectedIndicatorColor: .indigo)) {}
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

