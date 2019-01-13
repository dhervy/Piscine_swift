import Foundation

class Card : NSObject {
    var color: Color
    var value: Value
    
    
    init(color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        if object is Card && self == (object as! Card){
            return true
        }
        return false
    }
    
    
    static func ==(card: Card, card1: Card) -> Bool {
        if card.color == card1.color && card.value == card1.value {
            return true
        }
        return false
    }
    
    
    override var description: String {
        return "\(self.value) de \(self.color)"
    }
    
}