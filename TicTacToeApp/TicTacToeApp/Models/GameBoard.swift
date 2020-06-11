
class GameBoard: Board {
    
    private let rowsAndColoumns: Int
    private(set) var board: Matrix2D
    private(set) var currentPlayer: Player
    private var lastPlacedPlayer: Player?
    
    required init(with rowsAndColoumns: Int, player firstPlayer: Player) {
        
        self.rowsAndColoumns = rowsAndColoumns
        self.currentPlayer = firstPlayer
        self.board = Matrix2D(repeating: [Player?](repeating: nil,
                                                   count: rowsAndColoumns),
                              count: rowsAndColoumns)
    }
    
    var unfilledSquares: Int {
        
        var count = 0
        self.board.forEach { row in
            count = row.reduce(count) { count, player in
                return player == nil ? count + 1 : count
            }
        }
        return count
    }
    
    func player(at position: Position) throws -> Player? {
        
        func validateRange() throws {
            guard self.board.indices.contains(position.row),
                self.board[position.row].indices.contains(position.coloumn) else {
                    throw GameError.positionOutOfRange(message: GameConstants.invalidPosition)
            }
        }
        
        try validateRange()
        return self.board[position.row][position.coloumn]
    }
    
    func setCurrentPlayer(player: Player) throws {
        
        func validateIfFirst() throws {
            
            if self.unfilledSquares == self.rowsAndColoumns * self.rowsAndColoumns  {
                guard player == .x else {
                    throw GameError.playerXShouldMoveFirst(message: GameConstants.invalidFirstPlayer)
                }
            }
        }
        
        try validateIfFirst()
        
        guard player != self.lastPlacedPlayer else {
            throw GameError.samePlayerPlayedAgain(message: GameConstants.playerPlayedTwice)
        }
        
        self.currentPlayer = player
    }
    
    func placePlayer(at position: Position) throws {
        
        guard try self.player(at: position) == nil else {
            throw GameError.positionAlreadyPlayed(message: GameConstants.positionPlayed)
        }
        
        self.board[position.row][position.coloumn] = self.currentPlayer
        self.lastPlacedPlayer = self.currentPlayer
    }
}
