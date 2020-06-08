
struct GameBoard {
    
    var board: [[Player?]] = [[Player?]](repeating: [Player?](repeating: nil, count: 3), count: 3)
    private var currentPlayer: Player?
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
    
    func player(at position: Position) -> Player? {
        return self.board[position.row][position.coloumn]
    }
    
    mutating func setCurrentPlayer(player: Player) throws {
        
        try self.validateIfFirst(player: player)
        
        guard player != self.lastPlacedPlayer else {
            throw GameError.samePlayerPlayedAgain(message: GameConstants.playerPlayedAgain)
        }
        
        self.currentPlayer = player
    }
    
    mutating func placePlayer(at position: Position) throws {
        
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
