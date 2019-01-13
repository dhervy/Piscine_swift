import Foundation

class Deck : NSObject {
    init(sort: Bool) {
        super.init()
        if sort == false {
            self.cards.checker()
        }
    }
    
    override var description: String {
        return "\(self.cards)"
    }
    
    func draw () -> Card? {
        let new : Card?
        new = self.cards.first
        self.cards.remove(at: 0)
        if (new != nil) {
            self.outs.append(new!)
        }
        return new
    }
    
    func fold(c : Card) {
        var i = 0
        for value in self.outs {
            if c == value {
                self.discards.append(c)
                self.outs.remove (at: i)
            }
            i = i + 1;
        }
    }
    static let allSpades : [Card] = Value.allValues.map({Card(color:Color.Piques, value:$0)})
    static let allDiamonds : [Card] = Value.allValues.map({Card(color:Color.Carreaux, value:$0)})
    static let allHearts : [Card] = Value.allValues.map({Card(color:Color.Coeurs, value:$0)})
    static let allClubs : [Card] = Value.allValues.map({Card(color:Color.Trèfles, value:$0)})
    static let allCard : [Card] = allSpades + allHearts + allHearts + allDiamonds
    var cards : [Card] = allCard
    var discards : [Card] = []
    var outs : [Card] = []
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
