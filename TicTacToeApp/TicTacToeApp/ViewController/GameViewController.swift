
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private(set) var viewPresenter: GameViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewPresenter = GameViewPresenter(with: self)
    }
}

extension GameViewController: ViewPresenter {
    
    func moveResult(message: String) {
        
    }
}
