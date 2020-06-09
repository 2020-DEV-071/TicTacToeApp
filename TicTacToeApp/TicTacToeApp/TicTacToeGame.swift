
struct TicTacToeGame {
    
    private let resultAnalyser = ResultAnalyser()
    private(set) var gameBoard = GameBoard()
    private(set) var player = Player.x
    private var isGameEnd = false
    
    mutating func place(at position: Position) throws -> GameResult {
        
        try self.place(player: self.player, at: position)
    }
    
    mutating func place(player: Player, at position: Position) throws -> GameResult {
        
        guard !isGameEnd else {
            throw GameError.gameEnd(message: GameConstants.gameEnd)
        }
        
        try self.gameBoard.setCurrentPlayer(player: player)
        try self.gameBoard.placePlayer(at: position)
        
        let result = self.moveResult()
        self.swapPlayer()
        return result
    }
}

extension TicTacToeGame {
    
    mutating private func moveResult() -> GameResult {
        
        let result = self.resultAnalyser.gameStatus(for: self.gameBoard)
        self.isGameEnd = result != .inProgress ? true : false
        return result
    }
    
    mutating private func swapPlayer() {
        
        self.player = self.player == .x ? .o : .x
    }
}

