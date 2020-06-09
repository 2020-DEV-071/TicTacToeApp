
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
        
        return self.boardResult.gameStatus(for: self.gameBoard)
    }
}

struct BoardResult: WinCriteria {
    
     func gameStatus(for gameBoard: Board) -> GameResult {
        
        guard let currentPlayer = gameBoard.currentPlayer else { return .draw }
        
        guard self.isHorizontalRow(in: gameBoard) ||
            self.isVerticalRow(in: gameBoard)
        else {
            return .draw
        }
        
        return .win(player: currentPlayer)
    }
    
    private func isHorizontalRow(in gameBoard: Board) -> Bool {
        
        guard  let currentPlayer = gameBoard.currentPlayer else { return false }
        
        for row in gameBoard.board where row.count == 3 {
            if row.elementsEqual(self.winRow(for: currentPlayer)) {
                return true
            }
        }
        return false
    }
    
    private func isVerticalRow(in gameBoard: Board) -> Bool {
        
        guard  let currentPlayer = gameBoard.currentPlayer else { return false }
        
        for i in 0..<gameBoard.board.count {
            let coloumn = gameBoard.board.map { $0[i] }
            if coloumn.elementsEqual(self.winRow(for: currentPlayer)) {
                return true
            }
        }
        return false
    }
    
    func winRow(for player: Player) -> [Player] {
        
        return Array(repeating: player, count: 3)
    }
}
