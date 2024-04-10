import Foundation

public struct Answer: Codable, Equatable, Identifiable {
    public let id: UUID
    public let value: String
    
    public init(id: UUID, value: String) {
        self.id = id
        self.value = value
    }    
}
