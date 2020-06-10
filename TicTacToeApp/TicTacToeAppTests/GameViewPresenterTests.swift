
import XCTest
@testable import TicTacToeApp

class GameViewPresenterTests: XCTestCase {
    
    var presenter: GameViewPresenter!
    var expec: GameExpecatations!
    
    override func setUp() {
        super.setUp()
        self.expec = GameExpecatations()
        self.presenter = GameViewPresenter(with: GameViewControllerMock(with: self.expec))
    }
    
    override func tearDown() {
        self.expec = nil
        self.presenter = nil
        super.tearDown()
    }
    
    func test_didSelectFirstItem_returnsGameStatus() {
        
        self.presenter.didSelect(at: IndexPaths.r1c1)
        
        XCTAssertTrue(expec.didCallGameInProgress)
    }
    
    func test_didSelectAllItems_callsGameDraw() {
        
        let allItems = [IndexPaths.r0c0,
                        IndexPaths.r1c0,
                        IndexPaths.r2c0,
                        IndexPaths.r0c1,
                        IndexPaths.r0c2,
                        IndexPaths.r1c1,
                        IndexPaths.r1c2,
                        IndexPaths.r2c2,
                        IndexPaths.r2c1]
        
        self.selectItem(at: allItems)
        
        XCTAssertTrue(expec.didCallDraw)
    }
    
    func test_didSelectItemsPlacePlayerToWin_callsWin() {
        
        let winItems = [IndexPaths.r0c0,
                        IndexPaths.r1c0,
                        IndexPaths.r0c1,
                        IndexPaths.r1c1,
                        IndexPaths.r0c2]
        
        self.selectItem(at: winItems)
        
        XCTAssertTrue(expec.didCallWin)
    }
    
    
    func test_didSelectPreviouslySelectedItem_callsError() {
        
        let sameItems = [IndexPaths.r1c1, IndexPaths.r1c1]
        
        self.selectItem(at: sameItems)
        
        XCTAssertTrue(expec.didCallError)
    }
    
    func test_playerAtPosition_returnsPlacedPlayer() {
        
        self.presenter.didSelect(at: IndexPaths.r1c1)
        let player = self.presenter.player(at: IndexPaths.r1c1)
        
        XCTAssertEqual(player, Player.x)
    }
}

extension GameViewPresenterTests {
    
    private func selectItem(at positions: [IndexPath]) {
        
        positions.forEach {
            self.presenter.didSelect(at: $0)
        }
    }
}

protocol PresenterExpecatations {
    
    var didCallGameInProgress: Bool { get set }
    var didCallDraw: Bool { get set }
    var didCallWin: Bool { get set }
    var didCallError: Bool { get set }
}

class GameViewControllerMock: ViewPresenter {
    
    var expecatation: PresenterExpecatations!
    
    init(with expecatation: PresenterExpecatations) {
        self.expecatation = expecatation
    }
    
    func playerPlaced(with message: String) {
        self.expecatation.didCallGameInProgress = true
    }
    
    func gameDraw(with message: String) {
        self.expecatation.didCallDraw = true
    }
    
    func win(with message: String) {
        self.expecatation.didCallWin = true
    }
    
    func error(with message: String) {
        self.expecatation.didCallError = true
    }
}

class GameExpecatations: PresenterExpecatations {
    
    var didCallGameInProgress = false
    var didCallDraw = false
    var didCallWin = false
    var didCallError = false
}

enum IndexPaths {
    
    static let r0c0 = IndexPath(row: 0, section: 0)
    static let r0c1 = IndexPath(row: 0, section: 1)
    static let r0c2 = IndexPath(row: 0, section: 2)
    
    static let r1c0 = IndexPath(row: 1, section: 0)
    static let r1c1 = IndexPath(row: 1, section: 1)
    static let r1c2 = IndexPath(row: 1, section: 2)
    
    static let r2c0 = IndexPath(row: 2, section: 0)
    static let r2c1 = IndexPath(row: 2, section: 1)
    static let r2c2 = IndexPath(row: 2, section: 2)
}
