
import Foundation

class GameViewPresenter: GamePresenterProtocol {
    
    private let delegate: GameViewProtocol
    private var game: Game
    
    required init(with delegate: GameViewProtocol) {
        
        self.delegate = delegate
        let resultAnalyzer = ResultAnalyser()
        self.game = TicTacToeGame(with: resultAnalyzer)
    }
    
    func didSelect(at indexPath: IndexPath) {
        
        let position = Position(row: indexPath.row, coloumn: indexPath.section)
        do {
            let result = try self.game.place(at: position)
            self.showResult(for: indexPath, with: result)
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
    
    private func showResult(for indexPath: IndexPath, with result: GameResult) {
        
        self.delegate.didPlacePlayer(at: indexPath, with: result)
    }
    
    private func logError(with error: Error) {
        
        if let error = error as? GameError {
            
            switch error {
            case .gameEnd(let message),
                 .positionAlreadyPlayed(let message),
                 .positionOutOfRange(let message):
                self.delegate.error(with: message)
            }
        }
    }
    
}
