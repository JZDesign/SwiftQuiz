import SwiftUI

public extension EnvironmentValues {
    var quizStyle: Style {
        get { self[QuizStyleKey.self] }
        set { self[QuizStyleKey.self] = newValue }
    }
}

public struct QuizStyleKey: EnvironmentKey {
    public static let defaultValue = Style()
}
