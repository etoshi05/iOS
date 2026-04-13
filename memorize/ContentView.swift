import SwiftUI

struct ContentView: View {

    @State var viewModel = EmojiMemoryGame()

    var body: some View {
        VStack {
            cardList

            Spacer()

            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
        .foregroundStyle(.orange)
    }

    var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                ForEach(viewModel.cards, id: \.id) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)

            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            } else if !card.isMatched {
                shape.fill(.orange)
            }
        }
        .opacity(card.isMatched ? 0.3 : 1)
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
