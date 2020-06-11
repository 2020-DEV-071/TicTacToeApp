
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
    
    func playerPlaced(with message: String) {
        self.statusLabel.text = message
    }
    
    func win(with message: String) {
        self.statusLabel.text = message
    }
    
    func gameDraw(with message: String) {
        self.statusLabel.text = message
    }
    
    func error(with message: String) {
        self.statusLabel.text = message
    }
    
    func reloadGameView() {
        self.collectionView.reloadData()
    }
}
