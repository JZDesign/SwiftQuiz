import Foundation

public struct Answer: Codable, Equatable, Identifiable {
    public let id: UUID
    public let value: String
    
    public init(id: UUID, value: String) {
        self.id = id
        self.value = value
    }    
}

public struct WrittenAnswer {
    public let question: WrittenResponseQuestion
    public let answer: String

    public init(question: WrittenResponseQuestion, answer: String) {
        self.question = question
        self.answer = answer
    }

}
