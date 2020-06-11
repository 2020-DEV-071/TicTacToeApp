
import Foundation

protocol GamePresenterProtocol {
    
    init(with delegate: GameViewProtocol)
    func didSelect(at indexPath: IndexPath)
    func player(at indexPath: IndexPath) -> Player?
    func resetGame()
}
