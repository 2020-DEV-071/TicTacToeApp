
protocol Game {
    
    var gameBoard: Board { get }
    init(with winAnalyser: WinCriteria)
    func place(at position: Position) throws -> GameResult
}

class TicTacToeGame: Game {
    
    private let winAnalyser: WinCriteria
    private(set) var gameBoard: Board
    private(set) var player = Player.x
    private var isGameEnd = false
    
    required init(with winAnalyser: WinCriteria) {
        
        self.gameBoard = GameBoard(with: self.player)
        self.winAnalyser = winAnalyser
    }
    
    func place(at position: Position) throws -> GameResult {
        
        try self.place(player: self.player, at: position)
    }
}

extension TicTacToeGame {
    
    private func place(player: Player, at position: Position) throws -> GameResult {
        
        guard !isGameEnd else {
            throw GameError.gameEnd(message: GameConstants.gameEnd)
        }
        
        try self.gameBoard.set(player: player, at: position)
        
        let result = self.moveResult()
        self.swapPlayer()
        return result
    }
    
    private func moveResult() -> GameResult {
        
        let result = self.winAnalyser.gameStatus(for: self.gameBoard)
        self.isGameEnd = result != .inProgress ? true : false
        return result
    }
    
    private func swapPlayer() {
        
        self.player = self.player == .x ? .o : .x
    }
}

