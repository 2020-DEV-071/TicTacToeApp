
import Foundation

class GameViewPresenter: GamePresenterProtocol {
    
    let delegate: GameViewProtocol
    var game: Game
    
    required init(with delegate: GameViewProtocol) {
        
        self.delegate = delegate
        let resultAnalyzer = ResultAnalyser()
        self.game = TicTacToeGame(with: resultAnalyzer)
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
        
        let resultAnalyzer = ResultAnalyser()
        self.game = TicTacToeGame(with: resultAnalyzer)
        self.delegate.reloadGameView()
    }
}

extension GameViewPresenter {
    
    private func showResult(with result: GameResult) {
        switch result {
        case .inProgress:
            self.delegate.playerPlaced(with: "Game in progress")
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
