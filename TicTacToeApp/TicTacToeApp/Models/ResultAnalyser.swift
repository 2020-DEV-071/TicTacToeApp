
struct ResultAnalyser: WinCriteria {
    
    func gameStatus(for game: Board) -> GameResult {
        
        let winRow = self.matchingWinRow(for: game.currentPlayer)
        
        guard self.containsHorizontalRow(in: game.board, matching: winRow) ||
            self.containsVerticalRow(in: game.board, matching: winRow) ||
            self.containsDiagonalRow(in: game.board, matching: winRow)
            else {
                guard game.unfilledSquares != 0 else { return .draw }
                return .inProgress
        }
        
        return .win(player: game.currentPlayer)
    }
}

extension ResultAnalyser {
    
    private static let rowAndColoumns = 3
    
    private func containsHorizontalRow(in gameBoard: MatrixBoard, matching winRow: [Player]) -> Bool {
        
        for row in gameBoard where row.count == ResultAnalyser.rowAndColoumns {
            if row.elementsEqual(winRow) {
                return true
            }
        }
        return false
    }
    
    private func containsVerticalRow(in gameBoard: MatrixBoard, matching winRow: [Player]) -> Bool {
        
        for i in 0..<gameBoard.count {
            let coloumn = gameBoard.map { $0[i] }
            if coloumn.elementsEqual(winRow) {
                return true
            }
        }
        return false
    }
    
    private func containsDiagonalRow(in gameBoard: MatrixBoard, matching winRow: [Player]) -> Bool {
        
        var diagonal = [Player?]()
        
        func containsLeftDiagonal() -> Bool {
            for (rowIndex, rowElements) in gameBoard.enumerated() {
                diagonal.append(rowElements[rowIndex])
            }
            guard diagonal.elementsEqual(winRow) else { return false }
            return true
        }
        
        func containsRightDiagonal() -> Bool {
            diagonal.removeAll()
            for (rowIndex, rowElements) in gameBoard.reversed().enumerated() {
                diagonal.append(rowElements[rowIndex])
            }
            guard diagonal.elementsEqual(winRow) else { return false }
            return true
        }
        
        guard containsLeftDiagonal() ||
            containsRightDiagonal()
            else { return false }
        
        return true
    }
    
    private func matchingWinRow(for player: Player) -> [Player] {
        
        return Array(repeating: player, count: ResultAnalyser.rowAndColoumns)
    }
}
