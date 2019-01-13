var deck_sort = Deck(sort: true).cards

print("Cartes triée : ")
print(deck_sort)

var deck_shuffle = Deck(sort: false).cards

print("Cartes Mélangé : ")
print(deck_shuffle)

var deck = Deck(sort: false)

print("Le deck : ")
print(deck.cards)

print("La défausse : ")
print(deck.discards)

print("La main : ")
print(deck.outs)

print("On pioche : ")
var cart = deck.draw()

print("Le deck : ")
print(deck.cards)

print("La défausse : ")
print(deck.discards)

print("La main : ")
print(deck.outs)

print("On jette : ")
deck.fold(c : cart!)

print("Le deck : ")
print(deck.cards)

print("La défausse : ")
print(deck.discards)

print("La main : ")
print(deck.outs)