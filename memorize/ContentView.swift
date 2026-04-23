import SwiftUI

struct ContentView: View {
    @State private var viewModel: EmojiMemoryGame

    init(viewModel: EmojiMemoryGame) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            header
            cardList
            Spacer()
            HStack(spacing: 24) {
                newGameButton
                shuffleButton
            }
        }
        .padding()
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text("Emoji Memory Game")
                .font(.largeTitle)
                .bold()

            Text("主題：\(viewModel.themeName)")
                .font(.title2)
                .bold()
                .foregroundStyle(viewModel.themeColor)

            Text("分數：\(viewModel.score)")
                .font(.system(size: 30, weight: .heavy))
                .foregroundStyle(.pink)
        }
    }

    private var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                ForEach(viewModel.cards, id: \.id) { card in
                    CardView(card: card, color: viewModel.themeColor)
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }

    private var newGameButton: some View {
        Button {
            viewModel.newGame()
        } label: {
            VStack {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 28))
                Text("New Game")
                    .font(.headline)
            }
            .foregroundStyle(viewModel.themeColor)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }

    private var shuffleButton: some View {
        Button {
            viewModel.shuffle()
        } label: {
            VStack {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                Text("Shuffle")
                    .font(.subheadline)
            }
            .foregroundStyle(viewModel.themeColor)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)

            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(color, lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            } else if !card.isMatched {
                shape.fill(color)
            }
        }
        .opacity(card.isMatched ? 0.3 : 1)
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
