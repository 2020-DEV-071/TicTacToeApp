
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
        
        let result = self.resultAnalyser.gameStatus(for: self.gameBoard)
        self.isComplete = result != .inProgress ? true : false
        
        self.player = self.player == .x ? .o : .x
        
        return result
    }
}

struct ResultAnalyser: WinCriteria {
    
    func gameStatus(for gameBoard: Board) -> GameResult {
        
        guard let currentPlayer = gameBoard.currentPlayer else { return .draw }
        let winRow = self.winRow(for: currentPlayer)
        
        guard self.containsHorizontalRow(in: gameBoard.board, for: winRow) ||
            self.containsVerticalRow(in: gameBoard.board, for: winRow) ||
            self.containsDiagonalRow(in: gameBoard.board, for: winRow)
            else {
                guard gameBoard.unfilledSquares != 0 else { return .draw }
                return .inProgress
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
    
    private func containsDiagonalRow(in gameBoard: Matrix2D, for winRow: [Player]) -> Bool {
        
        var diagonal = [Player?]()
        
        func containsLeftDiagonal() -> Bool {
            for (n, x) in gameBoard.enumerated() {
                diagonal.append(x[n])
            }
            guard diagonal.elementsEqual(winRow) else { return false }
            return true
        }
        
        func containsRightDiagonal() -> Bool {
            diagonal.removeAll()
            for (n, x) in gameBoard.reversed().enumerated() {
                diagonal.append(x[n])
            }
            guard diagonal.elementsEqual(winRow) else { return false }
            return true
        }
        
        guard containsLeftDiagonal() ||
            containsRightDiagonal()
            else { return false }
        
        return true
    }
    
    func winRow(for player: Player) -> [Player] {
        
        return Array(repeating: player, count: 3)
    }
}
