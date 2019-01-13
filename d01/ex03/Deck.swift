import Foundation
// import Darwin

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({Card(color:Color.Piques, value:$0)})
    static let allDiamonds : [Card] = Value.allValues.map({Card(color:Color.Carreaux, value:$0)})
    static let allHearts : [Card] = Value.allValues.map({Card(color:Color.Coeurs, value:$0)})
    static let allClubs : [Card] = Value.allValues.map({Card(color:Color.Trèfles, value:$0)})
    static let allCard : [Card] = allSpades + allHearts + allHearts + allDiamonds
}

extension Array {
    mutating func checker () -> Array {
        var new : Array = []
        while self.count > 0 {
            let nb = arc4random_uniform(UInt32(self.count))
            let card = self[Int(nb)]
            self.remove(at: Int(nb))
            new.append(card)
        }
        self = new
        return self
    }
}
