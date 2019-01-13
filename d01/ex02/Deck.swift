import Foundation

class Deck : NSObject {
    static let allSpades : [Card] = Value.allValues.map({Card(color:Color.Piques, value:$0)})
    static let allDiamonds : [Card] = Value.allValues.map({Card(color:Color.Carreaux, value:$0)})
    static let allHearts : [Card] = Value.allValues.map({Card(color:Color.Coeurs, value:$0)})
    static let allClubs : [Card] = Value.allValues.map({Card(color:Color.Trèfles, value:$0)})
    static let allCard : [Card] = allSpades + allHearts + allHearts + allDiamonds
}