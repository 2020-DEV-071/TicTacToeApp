
import XCTest
@testable import TicTacToeApp

class ViewControllerTests: XCTestCase {
    
    var gameViewController: GameViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.gameViewController = storyboard.instantiateViewController(identifier: "ViewController")
        self.gameViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        
        self.gameViewController = nil
        super.tearDown()
    }
    
    func test_collectionViewIsNotNil_afterViewDidLoad() {
        
        XCTAssertNotNil(self.gameViewController.collectionView)
    }
    
    func test_collectionViewDataSourceIsNotNil_afterViewDidLoad() {
        
        XCTAssertTrue(self.gameViewController.collectionView.dataSource is GameViewController)
    }
    
    func test_numberOfSectionsInCollectionview_returns3() {
        
        let sectionsCount = self.gameViewController.collectionView.numberOfSections
        XCTAssertEqual(sectionsCount, 3)
    }
    
    func test_numberOfItemsInCollectionViewSections_returns3() {
        
        for section in 0...2 {
            let rowsCount = self.gameViewController.collectionView.numberOfItems(inSection: section)
            XCTAssertEqual(rowsCount, 3)
        }
    }
    
    func test_cellForItemAtIndexPath_returnsCell() {
        
        self.gameViewController.collectionView.reloadData()
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.gameViewController.collectionView.dequeueReusableCell(withReuseIdentifier: "DEFAULT_CELL", for: indexPath)
        
        XCTAssertNotNil(cell)
    }
    
    func test_viewControllerPresenter_isNotNil() {
        
        let presenter = self.gameViewController.viewPresenter
        XCTAssertNotNil(presenter)
    }
}

