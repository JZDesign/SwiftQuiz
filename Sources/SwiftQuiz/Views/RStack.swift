import SwiftUI

struct RStack<T: View>: View {
    @ViewBuilder let content: () -> T

    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.quizStyle) var style
    
    var body: some View {
        if dynamicTypeSize >= style.rstackThreshold {
            VStack {
                content()
            }
        } else {
            HStack {
                content()
                Spacer()
            }
        }
    }
}
