
import Foundation

protocol Presenter {
    
    init(with delegate: ViewPresenter)
    func didSelect(at indexPath: IndexPath)
    func player(at indexPath: IndexPath) -> Player?
    func resetGame()
}
