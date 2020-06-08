
struct TicTacToeGame {
    
    private let players: [Character] = ["X", "O"]
    
    var numberOfPlayers: Int {
        self.players.count
    }
    var firstPlayer: Character? {
        return players.first
    }
}
