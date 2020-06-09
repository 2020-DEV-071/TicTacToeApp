
import XCTest
@testable import TicTacToeApp

class ViewControllerTests: XCTestCase {
    
    var gameViewController: ViewController!
    
    override func setUp() {
        
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.gameViewController = storyboard.instantiateViewController(identifier: "ViewController")
    }
    
    override func tearDown() {
        
        self.gameViewController = nil
        super.tearDown()
    }
    
    func test_collectionViewIsNotNil_afterViewDidLoad() {
        
        self.gameViewController.loadViewIfNeeded()
        XCTAssertNotNil(self.gameViewController.collectionView)
    }
}
