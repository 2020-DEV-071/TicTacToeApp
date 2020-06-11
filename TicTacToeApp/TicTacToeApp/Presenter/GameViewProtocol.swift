
import Foundation

protocol GameViewProtocol {
    
    func didPlacePlayer(at indexPath: IndexPath, with result: GameResult)
    func error(with message: String)
    func reloadGameView()
}
