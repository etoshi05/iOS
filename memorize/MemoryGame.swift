import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private(set) var score = 0

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []

        for index in 0..<numberOfPairsOfCards {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: "\(index + 1)a"))
            cards.append(Card(content: content, id: "\(index + 1)b"))
        }
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        guard !cards[chosenIndex].isFaceUp else { return }
        guard !cards[chosenIndex].isMatched else { return }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2
            } else {
                if cards[chosenIndex].hasBeenSeen {
                    score -= 1
                }
                if cards[potentialMatchIndex].hasBeenSeen {
                    score -= 1
                }
                cards[chosenIndex].hasBeenSeen = true
                cards[potentialMatchIndex].hasBeenSeen = true
            }
            cards[chosenIndex].isFaceUp = true
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }

    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        let id: String
    }
}
