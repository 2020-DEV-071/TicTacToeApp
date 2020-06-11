
import Foundation

protocol ViewPresenter {
    
    func playerPlaced(with message: String)
    func gameDraw(with message: String)
    func win(with message: String)
    func error(with message: String)
    func reloadGameView()
}

protocol Presenter {
    
    init(with delegate: ViewPresenter)
    func didSelect(at indexPath: IndexPath)
    func player(at indexPath: IndexPath) -> Player?
    func resetGame()
}

class GameViewPresenter: Presenter {
    
    let delegate: ViewPresenter
    var game = TicTacToeGame()
    
    required init(with delegate: ViewPresenter) {
        self.delegate = delegate
    }
    
    func didSelect(at indexPath: IndexPath) {
        
        let position = Position(row: indexPath.row, coloumn: indexPath.section)
        do {
            let result = try self.game.place(at: position)
            showResult(with: result)
        } catch { 
            self.logError(with: error)
        }
    }
    
    func player(at indexPath: IndexPath) -> Player? {
        
        let position = Position(row: indexPath.row, coloumn: indexPath.section)
        let player = try? self.game.gameBoard.player(at: position)
        return player
    }
    
    func resetGame() {
        
        self.game = TicTacToeGame()
        self.delegate.reloadGameView()
    }
}

extension GameViewPresenter {
    
    private func showResult(with result: GameResult) {
        switch result {
        case .inProgress:
            self.delegate.playerPlaced(with: "In progress")
        case .draw:
            self.delegate.gameDraw(with: "Game Draw")
        case .win(let player):
            self.delegate.win(with: "Win!! \(player)")
        }
    }
    
    private func logError(with error: Error) {
        if let error = error as? GameError {
            
            switch error {
            case .gameEnd(let message),
                 .playerXShouldMoveFirst(let message),
                 .positionAlreadyPlayed(let message),
                 .samePlayerPlayedAgain(let message),
                 .positionOutOfRange(let message):
                self.delegate.error(with: message)
            }
        }
    }
}
