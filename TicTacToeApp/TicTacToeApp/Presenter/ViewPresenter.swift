
protocol ViewPresenter {
    
    func playerPlaced(with message: String)
    func gameDraw(with message: String)
    func win(with message: String)
    func error(with message: String)
    func reloadGameView()
}
