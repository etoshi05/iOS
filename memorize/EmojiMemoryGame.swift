import Foundation

struct EmojiMemoryGame {
    private static let emojis = ["鼠", "牛", "虎", "兔"]

    private var model: MemoryGame<String>

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    init() {
        model = MemoryGame<String>(numberOfPairsOfCards: 4) { index in
            Self.emojis[index]
        }
    }

    mutating func shuffle() {
        model.shuffle()
    }

    mutating func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
