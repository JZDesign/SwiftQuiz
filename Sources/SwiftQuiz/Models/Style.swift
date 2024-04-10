import SwiftUI

public struct Style {
    let unselectedIndicatorColor: Color
    let selectedIndicatorColor: Color
    let unselectedBorderColor: Color
    let selectedBorderColor: Color
    let cornerRadius: CGFloat
    let shouldFillHorizontalSpace: Bool
    
    public init(
        cornerRadius: CGFloat = 5,
        shouldFillHorizontalSpace: Bool = true,
        unselectedIndicatorColor: Color? = nil,
        selectedIndicatorColor: Color? = nil,
        unselectedBorderColor: Color? = nil,
        selectedBorderColor: Color? = nil
    ) {
        self.cornerRadius = cornerRadius
        self.shouldFillHorizontalSpace = shouldFillHorizontalSpace
        
        
        if let unselectedIndicatorColor {
            self.unselectedIndicatorColor = unselectedIndicatorColor
        } else {
            self.unselectedIndicatorColor = Color.primary
        }
        
        if let selectedIndicatorColor {
            self.selectedIndicatorColor = selectedIndicatorColor
        } else {
            self.selectedIndicatorColor = Color.primary
        }
        
        if let unselectedBorderColor {
            self.unselectedBorderColor = unselectedBorderColor
        } else {
            self.unselectedBorderColor = unselectedIndicatorColor ?? Color.primary
        }
        
        if let selectedBorderColor {
            self.selectedBorderColor = selectedBorderColor
        } else {
            self.selectedBorderColor = selectedIndicatorColor ?? Color.primary
        }
    }
}
