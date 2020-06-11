
import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    private static let cellIdentifier = "DEFAULT_CELL"
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewController.cellIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = self.playerColor(at: indexPath)
        return cell
    }
    
    private func playerColor(at indexPath: IndexPath) -> UIColor {
        
        guard let player = self.viewPresenter?.player(at: indexPath) else {
            return .gray
        }
        
        return player == .x ? .blue : .orange
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.viewPresenter?.didSelect(at: indexPath)
        self.collectionView.reloadItems(at: [indexPath])
    }
}

extension GameViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 110, height: 110)
    }
}

