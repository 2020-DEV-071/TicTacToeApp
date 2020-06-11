
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    @IBOutlet private(set) weak var statusLabel: UILabel!
    private(set) var viewPresenter: GamePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewPresenter = GameViewPresenter(with: self)
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        self.viewPresenter?.resetGame()
        self.statusLabel.text = ""
    }
}

extension GameViewController: GameViewProtocol {
        
    func didPlacePlayer(at indexPath: IndexPath, with result: GameResult) {
        
        switch result {
        case .inProgress:
            self.statusLabel.text = GameConstants.inProgress
        case .draw:
            self.statusLabel.text = GameConstants.draw
        case .win(let player):
            self.statusLabel.text = "\(GameConstants.win)\(player)!"
        }
    }
    
    func error(with message: String) {
        self.statusLabel.text = message
    }
    
    func reloadGameView() {
        self.collectionView.reloadData()
    }
}
