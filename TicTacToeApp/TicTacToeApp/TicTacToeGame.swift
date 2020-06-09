
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
        let winRow = self.winRow(for: currentPlayer)
        
        guard self.containsHorizontalRow(in: gameBoard.board, for: winRow) ||
            self.containsVerticalRow(in: gameBoard.board, for: winRow)
            else {
                return .draw
        }
        return .win(player: currentPlayer)
    }
    
    private func containsHorizontalRow(in gameBoard: Matrix2D, for winRow: [Player]) -> Bool {
        
        for row in gameBoard where row.count == 3 {
            if row.elementsEqual(winRow) {
                return true
            }
        }
        return false
    }
    
    private func containsVerticalRow(in gameBoard: Matrix2D, for winRow: [Player]) -> Bool {
        
        for i in 0..<gameBoard.count {
            let coloumn = gameBoard.map { $0[i] }
            if coloumn.elementsEqual(winRow) {
                return true
            }
        }
        return false
    }
    
    func winRow(for player: Player) -> [Player] {
        
        return Array(repeating: player, count: 3)
    }
}
