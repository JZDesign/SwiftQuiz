import Foundation

public enum Question: Codable {
    case singleChoice(SingleChoiceQuestion)
    case multipleChoice(MultipleChoiceQuestion)
    case shortform(WrittenResponseQuestion)
    case longform(WrittenResponseQuestion)
    
    var content: String {
        switch self {
        case .singleChoice(let singleChoiceQuestion):
            return singleChoiceQuestion.content
        case .multipleChoice(let multipleChoiceQuestion):
            return multipleChoiceQuestion.content
        case .shortform(let writtenResponseQuestion), .longform(let writtenResponseQuestion):
            return writtenResponseQuestion.content
        }
    }
    
    var id: UUID {
        switch self {
        case .singleChoice(let singleChoiceQuestion):
            return singleChoiceQuestion.id
        case .multipleChoice(let multipleChoiceQuestion):
            return multipleChoiceQuestion.id
        case .shortform(let writtenResponseQuestion), .longform(let writtenResponseQuestion):
            return writtenResponseQuestion.id
        }
    }
    
    public init(from decoder: Decoder) throws {
        if let single = try? SingleChoiceQuestion(from: decoder) {
            self = .singleChoice(single)
        } else if let multi = try? MultipleChoiceQuestion(from: decoder) {
            self = .multipleChoice(multi)
        } else {
            let written = try WrittenResponseQuestion(from: decoder)
            if written.type == .short {
                self = .shortform(written)
            } else {
                self = .longform(written)
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .singleChoice(let singleChoiceQuestion):
            try singleChoiceQuestion.encode(to: encoder)
        case .multipleChoice(let multipleChoiceQuestion):
            try multipleChoiceQuestion.encode(to: encoder)
        case .shortform(let writtenResponseQuestion), .longform(let writtenResponseQuestion):
            try writtenResponseQuestion.encode(to: encoder)
        }
    }
}
