import XCTest
@testable import SwiftQuiz

final class GradeTest: XCTestCase {
    let question = Question.singleChoice(.init(id: .init(), content: "test", options: [], correctAnswer: .init(id: .init(), value: "")))
    func test_gradeCalculations() {
        let tests = [
            (Grade(correct: [], incorrect: []), "0%"),
            (Grade(correct: [], incorrect: [question]), "0%"),
            (Grade(correct: [question], incorrect: [question]), "50%"),
            (Grade(correct: [question, question, question], incorrect: [question]), "75%"),
            (Grade(correct: [question, question, question], incorrect: []), "100%"),
            (Grade(correct: Array(repeating: question, count: 55), incorrect: Array(repeating: question, count: 8)), "87.3%"),
            
        ]
        
        tests.forEach { grade, score in
            XCTAssertEqual(grade.score.formatted(.percent.precision(.integerAndFractionLength(integerLimits: 0...3, fractionLimits: 0...2))), score)
        }
    }
}
