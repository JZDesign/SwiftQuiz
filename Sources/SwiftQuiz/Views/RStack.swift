import SwiftUI

struct RStack<T: View>: View {
    @ViewBuilder let content: () -> T

    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        if dynamicTypeSize.isAccessibilitySize {
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
