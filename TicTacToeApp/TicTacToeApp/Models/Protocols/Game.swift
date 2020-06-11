
protocol Game {
    
    var gameBoard: Board { get }
    init(with winAnalyser: WinCriteria)
    func place(at position: Position) throws -> GameResult
}
