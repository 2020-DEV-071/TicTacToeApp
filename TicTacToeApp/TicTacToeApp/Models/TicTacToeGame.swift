
enum GameError: Error, Equatable {
    
    case playerXShouldMoveFirst(message: String)
}

enum GameConstants {
    
    static let invalidFirstPlayer = "X should always goes first"
}

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
        
        if self.gameBoard.unfilledSquares == 9  {
            guard player == .x else {
                throw GameError.playerXShouldMoveFirst(message: GameConstants.invalidFirstPlayer)
            }
        }
        
        self.gameBoard.board[position.row][position.coloumn] = player
    }
    
}
