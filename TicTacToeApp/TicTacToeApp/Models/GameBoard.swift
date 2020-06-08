
struct GameBoard {
    
    var board: [[Player?]] = [[Player?]](repeating: [Player?](repeating: nil, count: 3), count: 3)
    
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
}
