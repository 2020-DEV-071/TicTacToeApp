
import Foundation

protocol ViewPresenter {
    
    func moveResult(message: String)
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
                self.delegate.moveResult(message: "Playing")
            default:
                self.delegate.moveResult(message: "")
            }
        } catch {
           print(error)
        }
    }
}
