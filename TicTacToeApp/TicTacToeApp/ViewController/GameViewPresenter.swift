
import Foundation

protocol ViewPresenter {
    
    func playerPlaced(with message: String)
    func gameDraw(with message: String)
    func win(with message: String)
    func error(with message: String)
}

class GameViewPresenter {
    
    let delegate: ViewPresenter
    let game = TicTacToeGame()
    
    init(with delegate: ViewPresenter) {
        self.delegate = delegate
    }
    
    func didSelect(at indexPath: IndexPath) {
        
        let position = Position(row: indexPath.row, coloumn: indexPath.section)
        
        do {
            let result = try self.game.place(at: position)
            
            switch result {
            case .inProgress:
                self.delegate.playerPlaced(with: "In progress")
            case .draw:
                self.delegate.gameDraw(with: "Game Draw")
            case .win(let player):
                self.delegate.win(with: "Win!! \(player)")
            }
        } catch { 
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
}
