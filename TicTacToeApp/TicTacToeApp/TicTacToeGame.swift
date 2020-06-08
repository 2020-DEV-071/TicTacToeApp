

struct TicTacToeGame {
    
    private let players = [Player.x, .o]
    private(set) var gameBoard: GameBoard = GameBoard()
    
    var numberOfPlayers: Int {
        self.players.count
    }
    var firstPlayer: Player? {
        self.players.first
    }
    var secondPlayer: Player? {
        self.players.last
    }
    
    mutating func place(player: Player, at position: Position) throws {
        
        try self.gameBoard.setCurrentPlayer(player: player)
        try self.gameBoard.placePlayer(at: position)
    }
}
