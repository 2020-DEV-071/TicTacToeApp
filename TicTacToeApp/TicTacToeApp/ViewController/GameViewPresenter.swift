
import Foundation

protocol ViewPresenter {
    
    func playerPlaced(with message: String)
    func gameEnd(with message: String)
    func win(with message: String)
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
                self.delegate.gameEnd(with: "Game Draw")
            case .win(let player):
                self.delegate.win(with: "Win!! \(player)")
            default:
                self.delegate.gameEnd(with: "")
            }
        } catch {
            print(error)
        }
    }
}
