
typealias Matrix2D = [[Player?]]

protocol Board {
    
    var board: Matrix2D { get }
    var currentPlayer: Player? { get }
    var unfilledSquares: Int { get }
}
