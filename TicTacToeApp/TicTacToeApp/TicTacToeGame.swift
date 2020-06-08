
struct TicTacToeGame {
    
    private let players: [Character] = ["X", "O"]
    
    var numberOfPlayers: Int {
        self.players.count
    }
    var firstPlayer: Character? {
        self.players.first
    }
    var secondPlayer: Character? {
        self.players.last
    }
}
