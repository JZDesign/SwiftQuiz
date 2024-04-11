import Foundation

public enum Answer {
    case singleSelected(SelectAnswer)
    case multiSelected([SelectAnswer])
    case written(WrittenAnswer)
}

public struct SelectAnswer: Codable, Equatable {
    public let value: String
    
    public init(value: String) {
        self.value = value
    }
}

public struct WrittenAnswer: Codable, Equatable {
    public let answer: String

    public init(answer: String) {
        self.answer = answer
    }
}
