import SwiftUI

public struct QuizView: View {
    let quiz: Quiz
    let evaluateWrittenResponse: (WrittenAnswer) -> Result<Void, Error>
    let onComplete: (Quiz, Grade) -> Void
    @State var currentQuestion: Question?
    @State var correct = [Question]()
    @State var incorrect = [Question]()
    @State var loading = false

    public init(
        quiz: Quiz,
        evaluateWrittenResponse: @escaping (WrittenAnswer) -> Result<Void, Error>,
        onComplete: @escaping (Quiz, Grade) -> Void
    ) {
        self.quiz = quiz
        self.evaluateWrittenResponse = evaluateWrittenResponse
        self.onComplete = onComplete
    }
    
    public var body: some View {
        _body
            .onAppear {
            if let first = quiz.questions.first {
                self.currentQuestion = first
            } else {
                onComplete(quiz, .init(correct: [], incorrect: []))
            }
        }
    }
    
    @ViewBuilder
    var _body: some View {
        if let currentQuestion {
            switch currentQuestion {
            case .singleChoice(let singleChoiceQuestion):
                SingleChoiceQuestionView(question: singleChoiceQuestion) { answer in
                    if singleChoiceQuestion.correctAnswer == answer {
                        correct.append(currentQuestion)
                    } else {
                        incorrect.append(currentQuestion)
                    }
                    nextQuestion()
                }
            case .multipleChoice(let multipleChoiceQuestion):
                MultipleChoiceQuestionView(question: multipleChoiceQuestion) { answers in
                    if multipleChoiceQuestion.correctAnswers == answers {
                        correct.append(currentQuestion)
                    } else {
                        incorrect.append(currentQuestion)
                    }
                    nextQuestion()
                }
            case .shortform(let writtenResponseQuestion):
                WrittenAnswerQuestionView(question: writtenResponseQuestion) { answer in
                    switch evaluateWrittenResponse(WrittenAnswer(question: writtenResponseQuestion, answer: answer)) {
                    case .success:
                        correct.append(currentQuestion)
                        nextQuestion()
                    case .failure:
                        incorrect.append(currentQuestion)
                        nextQuestion()
                    }
                }
            case .longform(let writtenResponseQuestion):
                WrittenAnswerQuestionView(question: writtenResponseQuestion) { answer in
                    switch evaluateWrittenResponse(WrittenAnswer(question: writtenResponseQuestion, answer: answer)) {
                    case .success:
                        correct.append(currentQuestion)
                        nextQuestion()
                    case .failure:
                        incorrect.append(currentQuestion)
                        nextQuestion()
                    }
                }
            }
        } else {
            ProgressView()
        }
    }
    
    func nextQuestion() {

        let question = currentQuestion
        withAnimation {
            currentQuestion = nil
        }
        guard let index = quiz.questions.firstIndex(where: { q in
            q.id == question?.id
        }) else {
            return // TODO: handle error
        }
        
        withAnimation {
            if index < quiz.questions.count - 1 {
                currentQuestion = quiz.questions[index + 1]
            } else {
                onComplete(quiz, Grade(correct: correct, incorrect: incorrect))
            }
        }
    }
}


#Preview {
    _preview()
        .environment(\.quizStyle, Style(unselectedPrimaryColor: .gray, selectedPrimaryColor: .cyan))
}

struct _preview: View {
    
    @State var grade: Decimal = 0
    @State var complete = false
    
    @ViewBuilder
    var body: some View {
        if complete {
            Text(grade, format: .percent)
        } else {
            QuizView(
                quiz: .init(id: .init(), questions: [
                    .singleChoice(
                        .init(
                            id: .init(),
                            content: "What is the answer to life and everything?",
                            options: [
                                .init(id: .init(), value: "Some long winded answer that really means nothing."),
                                .init(id: .init(), value: "Some answer"),
                                .init(id: UUID(uuidString: "6278CCCA-1629-41C9-AED0-3C8A2286D447")!, value: "42"),
                                .init(id: .init(), value: "cheese is good"),
                            ],
                            correctAnswer: .init(id: UUID(uuidString: "6278CCCA-1629-41C9-AED0-3C8A2286D447")!, value: "42")
                        )
                    ),
                    .multipleChoice(
                        .init(
                            id: .init(),
                            content: "What is the answer to life and everything?",
                            options: [
                                .init(id: .init(), value: "Some long winded answer that really means nothing."),
                                .init(id: .init(), value: "Some answer"),
                                .init(id: UUID(uuidString: "6278CCCA-1629-41C9-AED0-3C8A2286D447")!, value: "42"),
                                .init(id: .init(), value: "cheese is good"),
                            ],
                            correctAnswers: [.init(id: UUID(uuidString: "6278CCCA-1629-41C9-AED0-3C8A2286D447")!, value: "42")]
                        )
                    ),
                    .shortform(.init(id: .init(), content: "Tell me what your name is", type: .short)),
                    .longform(.init(id: .init(), content: "Why is the sky blue", type: .long))
                ])) { answer in
                    return .success(())
                } onComplete: { quiz, grade in
                    self.grade = grade.score
                    complete = true
                }
        }
    }
}


