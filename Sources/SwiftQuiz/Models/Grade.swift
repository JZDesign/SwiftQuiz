import Foundation

public struct Grade {
    public let correct: [Question]
    public let incorrect: [Question]
    public let score: Decimal
    
    init(correct: [Question], incorrect: [Question]) {
        self.correct = correct
        self.incorrect = incorrect
    
        guard correct.count > 0 else {
            score = 0
            return
        }

        let totalQuestions = Decimal(Double(correct.count + incorrect.count))
        score = (Decimal(Double(correct.count)) / totalQuestions)
    }
}
