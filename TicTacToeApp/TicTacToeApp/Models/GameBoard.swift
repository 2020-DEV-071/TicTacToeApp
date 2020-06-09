
struct GameBoard: Board {
    
    private(set) var board: [[Player?]] = [[Player?]](repeating: [Player?](repeating: nil, count: 3), count: 3)
    private(set) var currentPlayer: Player?
    private var lastPlacedPlayer: Player?
    
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
        
        guard self.board.indices.contains(position.row),
            self.board[position.row].indices.contains(position.coloumn
            ) else { throw GameError.positionOutOfRange(message: GameConstants.invalidPosition) }
        
        return self.board[position.row][position.coloumn]
    }
    
    mutating func setCurrentPlayer(player: Player) throws {
        
        try self.validateIfFirst(player: player)
        
        guard player != self.lastPlacedPlayer else {
            throw GameError.samePlayerPlayedAgain(message: GameConstants.playerPlayedTwice)
        }
        
        self.currentPlayer = player
    }
    
    mutating func placePlayer(at position: Position) throws {
        
        guard try self.player(at: position) == nil else {
            throw GameError.positionAlreadyPlayed(message: GameConstants.positionPlayed)
        }
        
        self.board[position.row][position.coloumn] = self.currentPlayer
        self.lastPlacedPlayer = self.currentPlayer
    }
    
    private func validateIfFirst(player: Player) throws {
        
        if self.unfilledSquares == 9  {
            guard player == .x else {
                throw GameError.playerXShouldMoveFirst(message: GameConstants.invalidFirstPlayer)
            }
        }
    }
}
