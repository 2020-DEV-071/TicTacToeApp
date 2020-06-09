
struct TicTacToeGame {
    
    private let players = [Player.x, .o]
    private(set) var gameBoard: GameBoard = GameBoard()
    private let boardResult = BoardResult()
    
    var numberOfPlayers: Int {
        self.players.count
    }
    var firstPlayer: Player? {
        self.players.first
    }
    var secondPlayer: Player? {
        self.players.last
    }
    
    mutating func place(player: Player, at position: Position) throws -> GameResult {
        
        try self.gameBoard.setCurrentPlayer(player: player)
        try self.gameBoard.placePlayer(at: position)
        
        return self.gameStatus()
    }
    
    private func gameStatus() -> GameResult {
        
        guard let result = self.boardResult.isHorizontalRow(in: self.gameBoard) else {
            return .draw
        }
        
        return result
    }
}

struct BoardResult: WinCriteria {
    
    func isHorizontalRow(in gameBoard: Board) -> GameResult? {
        
        guard  let currentPlayer = gameBoard.currentPlayer else { return nil }
        
        for row in gameBoard.board where row.count == 3 {
            if row.elementsEqual(self.winRow(for: currentPlayer)) {
                return .win(player: currentPlayer)
            }
        }
        return .draw
    }
    
    func winRow(for player: Player) -> [Player] {
        
        return Array(repeating: player, count: 3)
    }
}
