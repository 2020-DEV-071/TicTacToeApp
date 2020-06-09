
protocol Board {
    
    var board: [[Player?]] { get }
    func winRow() -> [Player]?
}
