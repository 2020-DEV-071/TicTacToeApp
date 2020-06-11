
class GameBoard: Board {
    
    private let rowsAndColoumns = 3
    private(set) var board: MatrixBoard
    private(set) var currentPlayer: Player
    
    required init(with firstPlayer: Player) {
        
        self.currentPlayer = firstPlayer
        self.board = MatrixBoard(repeating: [Player?](repeating: nil,
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
    
    func set(player: Player, at position: Position) throws {
        
        self.currentPlayer = player
        
        guard try self.player(at: position) == nil else {
            throw GameError.positionAlreadyPlayed(message: GameConstants.positionPlayed)
        }
        
        self.board[position.row][position.coloumn] = self.currentPlayer
    }
}
