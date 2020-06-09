
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
        
        return self.gameStatus() ? .win : .draw
    }
    
    private func gameStatus() -> Bool {
        return self.boardResult.isHorizontalRow(board: self.gameBoard)
    }
}

struct BoardResult: WinCriteria {
    
    func isHorizontalRow(board: Board) -> Bool {
        
        for row in board.board where row.count == 3 {
            if row.elementsEqual(board.winRow() ?? [Player.x]) {
                return true
            }
        }
        return false
    }
}
