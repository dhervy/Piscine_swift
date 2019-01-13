let p = Card(color: Color.Carreaux, value: Value.As)
let p2 = Card(color: Color.Carreaux, value: Value.As)
let p4 = Card(color: Color.Coeurs, value: Value.As)
let p3 = Card(color: Color.Coeurs, value: Value.Trois)

print("Carte1 : \(p)");
print("Carte2 : \(p2)");
print("Carte3 : \(p3)");
print("Carte4 : \(p4)");

print("\(p) isEqual(\(p2)) : \(p.isEqual(p2))");
print("\(p) isEqual(\(p4)) : \(p.isEqual(p4))");
print("\(p3) isEqual(\(p4)) : \(p3.isEqual(p4))");
print("\(p) isEqual(\(p3)) : \(p.isEqual(p3))");

print("\(p2) == \(p3) : \(p2 == p3)")
print("\(p) == \(p2) : \(p == p2)")
print("\(p2) == \(p4) : \(p2 == p4)")
print("\(p3) == \(p4) : \(p3 == p4)")
