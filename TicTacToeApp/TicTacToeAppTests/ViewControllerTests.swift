
import XCTest
@testable import TicTacToeApp

class ViewControllerTests: XCTestCase {
    
    var gameVC: GameViewController!
    
    override func setUp() {
        super.setUp()
        self.loadViewControllerFromStoryboard()
    }
    
    override func tearDown() {
        self.gameVC = nil
        super.tearDown()
    }
    
    func test_collectionViewIsNotNil_afterViewDidLoad() {
        
        XCTAssertNotNil(self.gameVC.collectionView)
    }
    
    func test_collectionViewDataSourceIsSet_afterViewDidLoad() {
        
        XCTAssertTrue(self.gameVC.collectionView.dataSource is GameViewController)
    }
    
    func test_collectionViewDelegateIsSet_afterViewDidLoad() {
        
        XCTAssertTrue(self.gameVC.collectionView.delegate is GameViewController)
    }
    
    func test_numberOfSectionsInCollectionview_returns3() {
        
        let sectionsCount = self.gameVC.collectionView.numberOfSections
        XCTAssertEqual(sectionsCount, 3)
    }
    
    func test_numberOfItemsInCollectionViewSections_returns3() {
        
        for section in 0..<self.gameVC.collectionView.numberOfSections {
            let rowsCount = self.gameVC.collectionView.numberOfItems(inSection: section)
            XCTAssertEqual(rowsCount, 3)
        }
    }
    
    func test_cellForItemAtIndexPath_returnsCell() {
        
        let cell2 = self.gameVC.collectionView(self.gameVC.collectionView,
                                               cellForItemAt: IndexPaths.r0c0)
        
        XCTAssertNotNil(cell2)
    }
    
    func test_viewControllerPresenter_isNotNil() {
        
        let presenter = self.gameVC.viewPresenter
        XCTAssertNotNil(presenter)
    }
    
    func test_selectCollectionViewItem_setStatusInProgress() {
        
        let collectionView = self.gameVC.collectionView!
        
        collectionView.selectItem(at: IndexPaths.r0c0,
                                  animated: false,
                                  scrollPosition: .centeredVertically)
        
        self.gameVC.collectionView(collectionView,
                                   didSelectItemAt: IndexPaths.r0c0)
        
        XCTAssertEqual(self.gameVC.statusLabel.text!, "Game in progress")
    }
    
    func test_selectCollectionViewAllItems_setStatusDraw() {
        
        let drawCellItems = [IndexPaths.r0c0,
                             IndexPaths.r1c0,
                             IndexPaths.r2c0,
                             IndexPaths.r0c1,
                             IndexPaths.r0c2,
                             IndexPaths.r1c1,
                             IndexPaths.r1c2,
                             IndexPaths.r2c2,
                             IndexPaths.r2c1]
        
        self.selectItems(at: drawCellItems)
        
        XCTAssertEqual(self.gameVC.statusLabel.text!, "Game Draw")
    }
    
    func test_selectCollectionViewItemsToWin_setStatusWin() {
        
        let leftDiagonalCellItems = [IndexPaths.r0c0,
                                     IndexPaths.r0c1,
                                     IndexPaths.r1c1,
                                     IndexPaths.r0c2,
                                     IndexPaths.r2c2]
        
        self.selectItems(at: leftDiagonalCellItems)
        
        XCTAssertEqual(self.gameVC.statusLabel.text!, "Win!! x")
    }
    
    func test_selectCollectionViewSameItemTwice_setStatusError() {
        
        let sameCellItems = [IndexPaths.r0c0,
                             IndexPaths.r0c0]
        
        self.selectItems(at: sameCellItems)
        
        XCTAssertEqual(self.gameVC.statusLabel.text!, "Position already played")
    }
    
    func test_resetGame_clearsAllItems() {
        
        let firstTwoItems = [IndexPaths.r0c0, IndexPaths.r0c1]
        self.selectItems(at: firstTwoItems)
        self.gameVC.resetGame(UIButton())
        
        let allItems = [IndexPaths.r0c0,
                        IndexPaths.r1c0,
                        IndexPaths.r2c0,
                        IndexPaths.r0c1,
                        IndexPaths.r0c2,
                        IndexPaths.r1c1,
                        IndexPaths.r1c2,
                        IndexPaths.r2c2,
                        IndexPaths.r2c1]
        
        for indexItem in allItems {
            
            let cell = self.gameVC.collectionView(self.gameVC.collectionView,
                                                  cellForItemAt: indexItem)
            XCTAssertEqual(cell.contentView.backgroundColor, UIColor.gray)
        }
    }
}

extension ViewControllerTests {
    
    private func loadViewControllerFromStoryboard() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.gameVC = storyboard.instantiateViewController(identifier: "ViewController")
        self.gameVC.loadViewIfNeeded()
    }
    
    private func selectItems(at indexPaths: [IndexPath]) {
        
        let collectionView = self.gameVC.collectionView!
        
        indexPaths.forEach {
            collectionView.selectItem(at: $0,
                                      animated: false,
                                      scrollPosition: .centeredVertically)
            
            self.gameVC.collectionView(collectionView,
                                       didSelectItemAt: $0)
        }
    }
}
