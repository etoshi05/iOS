import SwiftUI

struct EmojiMemoryGame {
    private(set) var themePool: ThemePool<String>
    private(set) var theme: ThemePool<String>.Theme
    private var model: MemoryGame<String>

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    var themeName: String {
        theme.name
    }

    var themeColor: Color {
        theme.color
    }

    init() {
        themePool = EmojiMemoryGame.createThemePool()
        theme = themePool.randomTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

    mutating func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    mutating func shuffle() {
        model.shuffle()
    }

    mutating func newGame() {
        theme = themePool.randomTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

    private static func createMemoryGame(with theme: ThemePool<String>.Theme) -> MemoryGame<String> {
        let shuffledItems = theme.items.shuffled()
        let pairCount = min(theme.numberOfPairs, shuffledItems.count)

        return MemoryGame<String>(numberOfPairsOfCards: pairCount) { index in
            shuffledItems[index]
        }
    }

    private static func createThemePool() -> ThemePool<String> {
        var pool = ThemePool<String>()

        pool.addTheme(
            ThemePool<String>.Theme(
                name: "動物",
                color: .orange,
                numberOfPairs: 6,
                items: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐯", "🐸"]
            )
        )

        pool.addTheme(
            ThemePool<String>.Theme(
                name: "水果",
                color: .red,
                numberOfPairs: 6,
                items: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍑", "🥝"]
            )
        )

        pool.addTheme(
            ThemePool<String>.Theme(
                name: "交通工具",
                color: .blue,
                numberOfPairs: 6,
                items: ["🚗", "🚌", "🚑", "🚒", "🚜", "✈️", "🚀", "🚲", "🚂", "🛵"]
            )
        )

        pool.addTheme(
            ThemePool<String>.Theme(
                name: "天氣",
                color: .purple,
                numberOfPairs: 6,
                items: ["☀️", "🌤️", "⛅️", "🌧️", "⛈️", "❄️", "🌈", "🌪️", "🌙", "⭐️"]
            )
        )

        return pool
    }

    struct ThemePool<Item> {
        private(set) var themes: [Theme] = []

        mutating func addTheme(_ theme: Theme) {
            themes.append(theme)
        }

        func randomTheme() -> Theme {
            themes.randomElement() ?? Theme(name: "預設", color: .gray, numberOfPairs: 0, items: [])
        }

        struct Theme {
            let name: String
            let color: Color
            let numberOfPairs: Int
            let items: [Item]
        }
    }
}
