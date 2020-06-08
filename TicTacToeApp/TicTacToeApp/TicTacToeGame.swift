
enum Player: Character {
    
    case x = "X"
    case o = "O"
}

struct TicTacToeGame {
    
    private let players = [Player.x, .o]
    
    var numberOfPlayers: Int {
        self.players.count
    }
    var firstPlayer: Player? {
        self.players.first
    }
    var secondPlayer: Player? {
        self.players.last
    }
}
