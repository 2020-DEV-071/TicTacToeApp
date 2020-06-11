
typealias Matrix2D = [[Player?]]

protocol Board {
    
    var board: Matrix2D { get }
    var currentPlayer: Player { get }
    var unfilledSquares: Int { get }
    
    init(with rowsAndColoumns: Int, player firstPlayer: Player)
    func setCurrentPlayer(player: Player) throws
    func placePlayer(at position: Position) throws
    func player(at position: Position) throws -> Player?
}
