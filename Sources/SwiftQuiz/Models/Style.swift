import SwiftUI

public struct Style {
    let unselectedPrimaryColor: Color
    let selectedPrimaryColor: Color
    let unselectedBorderColor: Color
    let selectedBorderColor: Color
    let cornerRadius: CGFloat
    let shouldFillHorizontalSpace: Bool
    
    public init(
        cornerRadius: CGFloat = 5,
        shouldFillHorizontalSpace: Bool = true,
        unselectedPrimaryColor: Color? = nil,
        selectedPrimaryColor: Color? = nil,
        unselectedBorderColor: Color? = nil,
        selectedBorderColor: Color? = nil
    ) {
        self.cornerRadius = cornerRadius
        self.shouldFillHorizontalSpace = shouldFillHorizontalSpace
        
        
        if let unselectedPrimaryColor {
            self.unselectedPrimaryColor = unselectedPrimaryColor
        } else {
            self.unselectedPrimaryColor = Color.primary
        }
        
        if let selectedPrimaryColor {
            self.selectedPrimaryColor = selectedPrimaryColor
        } else {
            self.selectedPrimaryColor = Color.primary
        }
        
        if let unselectedBorderColor {
            self.unselectedBorderColor = unselectedBorderColor
        } else {
            self.unselectedBorderColor = unselectedPrimaryColor ?? Color.primary
        }
        
        if let selectedBorderColor {
            self.selectedBorderColor = selectedBorderColor
        } else {
            self.selectedBorderColor = selectedPrimaryColor ?? Color.primary
        }
    }
}
