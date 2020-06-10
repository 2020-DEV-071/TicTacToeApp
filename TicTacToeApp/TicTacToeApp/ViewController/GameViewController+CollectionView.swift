
import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DEFAULT_CELL", for: indexPath)
        
        guard let player = self.viewPresenter?.player(at: indexPath) else {
            cell.contentView.backgroundColor = .gray
            return cell
        }
        let playerColor: UIColor = player == .x ? .blue : .orange
        cell.contentView.backgroundColor = playerColor
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.viewPresenter?.didSelect(at: indexPath)
        self.collectionView.reloadItems(at: [indexPath])
        
        print(indexPath)
    }
}

extension GameViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 110, height: 110)
    }
}

