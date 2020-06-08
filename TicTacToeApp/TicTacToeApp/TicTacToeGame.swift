
enum Player: Character {
    
    case x = "X"
    case o = "O"
}

struct Position {
    
    let row: Int
    let coloumn: Int
}

struct TicTacToeGame {
    
    private let players = [Player.x, .o]
    private var board: [[Player?]] = [[Player?]](repeating: [Player?](repeating: nil, count: 3), count: 3)
    
    var numberOfPlayers: Int {
        self.players.count
    }
    var firstPlayer: Player? {
        self.players.first
    }
    var secondPlayer: Player? {
        self.players.last
    }
    
    var unfilledSquares: Int {
        var count = 0
        self.board.forEach { row in
            count = row.reduce(count) { count, player in
                return player == nil ? count + 1 : count
            }
        }
        return count
    }
    
    mutating func place(player: Player, at position: Position) throws {
        
        self.board[position.row][position.coloumn] = player
    }
    
    func player(at position: Position) -> Player? {
        
        return self.board[position.row][position.coloumn]
    }
}
