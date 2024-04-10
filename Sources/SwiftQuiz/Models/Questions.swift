import Foundation

public struct SingleChoiceQuestion: Codable {
    public let id: UUID
    public let content: String
    public let options: [SelectAnswer]
    public let correctAnswer: SelectAnswer
    
    public init(id: UUID, content: String, options: [SelectAnswer], correctAnswer: SelectAnswer) {
        self.id = id
        self.content = content
        self.options = options
        self.correctAnswer = correctAnswer
    }
}

public struct MultipleChoiceQuestion: Codable {
    public let id: UUID
    public let content: String
    public let options: [SelectAnswer]
    public let correctAnswers: [SelectAnswer]
    
    public init(id: UUID, content: String, options: [SelectAnswer], correctAnswers: [SelectAnswer]) {
        self.id = id
        self.content = content
        self.options = options
        self.correctAnswers = correctAnswers
    }
}

public struct MultiSelectSurveyQuestion: Codable {
    public let id: UUID
    public let content: String
    public let options: [SelectAnswer]
    public let selectAtLeast: UInt
    public let selectAtMost: UInt
    
    public init(id: UUID, content: String, options: [SelectAnswer], selectAtLeast: UInt, selectAtMost: UInt) {
        self.id = id
        self.content = content
        self.options = options
        self.selectAtLeast = selectAtLeast
        self.selectAtMost = selectAtMost
    }
}


public struct WrittenResponseQuestion: Codable {
    public let id: UUID
    public let content: String
    public let type: ResponseType
    
    public enum ResponseType: String, Codable {
        case short, long
    }
    
    public init(id: UUID, content: String, type: ResponseType) {
        self.id = id
        self.content = content
        self.type = type
    }
}
