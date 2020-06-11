
typealias MatrixBoard = [[Player?]]

protocol Board {
    
    var board: MatrixBoard { get }
    var currentPlayer: Player { get }
    var unfilledSquares: Int { get }
    
    init(with firstPlayer: Player)
    func setCurrentPlayer(player: Player) throws
    func placePlayer(at position: Position) throws
    func player(at position: Position) throws -> Player?
}
