import Foundation

public struct Quiz: Codable {
    let id: UUID
    let questions: [Question]
    
    public init(id: UUID, questions: [Question]) {
        self.id = id
        self.questions = questions
    }
}
