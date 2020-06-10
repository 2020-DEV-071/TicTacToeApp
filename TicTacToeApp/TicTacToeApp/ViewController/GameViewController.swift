
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private(set) var viewPresenter: ViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewPresenter = GameViewPresenter()
    }
}


protocol ViewPresenter {
    
}

class GameViewPresenter: ViewPresenter {
    
    
}
