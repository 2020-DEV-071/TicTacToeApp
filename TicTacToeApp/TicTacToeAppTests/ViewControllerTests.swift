
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
}
