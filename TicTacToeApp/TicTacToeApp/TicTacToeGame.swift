
struct TicTacToeGame {
    
    private(set) var gameBoard: GameBoard = GameBoard()
    private let resultAnalyser = ResultAnalyser()
    private var isComplete = false
    
    private(set) var player = Player.x
    
    mutating func place(at position: Position) throws -> GameResult {
        
        try self.place(player: self.player, at: position)
    }
    
    mutating func place(player: Player, at position: Position) throws -> GameResult {
        
        guard !isComplete else {
            throw GameError.gameEnd(message: GameConstants.gameEnd)
        }
        
        try self.gameBoard.setCurrentPlayer(player: player)
        try self.gameBoard.placePlayer(at: position)
        
        let result = self.moveResult()
        self.swapPlayer()
        
        return result
    }
    
    mutating private func moveResult() -> GameResult {
        
        let result = self.resultAnalyser.gameStatus(for: self.gameBoard)
        self.isComplete = result != .inProgress ? true : false
        return result
    }
    
    mutating private func swapPlayer() {
        
        self.player = self.player == .x ? .o : .x
    }
}

