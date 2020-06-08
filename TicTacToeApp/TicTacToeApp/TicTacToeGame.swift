

struct TicTacToeGame {
    
    private let players = [Player.x, .o]
    private(set) var gameBoard: GameBoard = GameBoard()
    
    private var lastPlacedPlayer: Player?
    
    
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
        
        if self.gameBoard.unfilledSquares == 9  {
            guard player == .x else {
                throw GameError.playerXShouldMoveFirst(message: GameConstants.invalidFirstPlayer)
            }
        }
        
        guard player != self.lastPlacedPlayer else {
            throw GameError.samePlayerPlayedAgain(message: GameConstants.playerPlayedAgain)
        }
        
        self.gameBoard.board[position.row][position.coloumn] = player
        self.lastPlacedPlayer = player
    }
}
