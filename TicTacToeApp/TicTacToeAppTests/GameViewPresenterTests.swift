
import XCTest
@testable import TicTacToeApp

class GameViewPresenterTests: XCTestCase {
    
    var presenter: GameViewPresenter!
    var expec: BindExpecatations!
    
    override func setUp() {
        super.setUp()
        self.expec = BindExpecatations()
        self.presenter = GameViewPresenter(with: GameViewControllerMock(with: self.expec))
    }
    
    override func tearDown() {
        self.expec = nil
        self.presenter = nil
        super.tearDown()
    }
    
    func test_didSelectFirstItem_returnsGameStatus() {
        
        self.presenter.didSelect(at: IndexPaths.r1c1)
        self.wait(for: [expec.didCallGameInProgress], timeout: 2)
    }
    
    func test_didSelectAllItems_returnsGameDraw() {
        
        self.presenter.didSelect(at: IndexPaths.r0c0)
        self.presenter.didSelect(at: IndexPaths.r1c0)
        self.presenter.didSelect(at: IndexPaths.r2c0)
        self.presenter.didSelect(at: IndexPaths.r0c1)
        self.presenter.didSelect(at: IndexPaths.r0c2)
        self.presenter.didSelect(at: IndexPaths.r1c1)
        self.presenter.didSelect(at: IndexPaths.r1c2)
        self.presenter.didSelect(at: IndexPaths.r2c2)
        self.presenter.didSelect(at: IndexPaths.r2c1)
        
        self.wait(for: [expec.didCallDraw], timeout: 2)
    }
    
    func test_didSelectItemsPlacePlayerToWin_returnsWin() {
        
        self.presenter.didSelect(at: IndexPaths.r0c0)
        self.presenter.didSelect(at: IndexPaths.r1c0)
        self.presenter.didSelect(at: IndexPaths.r0c1)
        self.presenter.didSelect(at: IndexPaths.r1c1)
        self.presenter.didSelect(at: IndexPaths.r0c2)
        
        self.wait(for: [self.expec.didCallWin], timeout: 2)
    }
    
    
    func test_didSelectItemPreviouslySelected_returnsErrorMessage() {
        
        self.presenter.didSelect(at: IndexPaths.r1c1)
        self.presenter.didSelect(at: IndexPaths.r1c1)
        
        self.wait(for: [self.expec.didCallError], timeout: 2)
    }
    
    func test_playerAtPosition_returnsPlacedPlayer() {
        
        self.presenter.didSelect(at: IndexPaths.r1c1)
        let player = self.presenter.player(at: IndexPaths.r1c1)
        
        XCTAssertEqual(player, Player.x)
    }
}

protocol ViewExpecatations {
    
    var didCallGameInProgress: XCTestExpectation { get }
    var didCallDraw: XCTestExpectation { get }
    var didCallWin: XCTestExpectation { get }
    var didCallError: XCTestExpectation { get }
}

class GameViewControllerMock: ViewPresenter {
    
    var expecatation: ViewExpecatations!
    
    init(with expecatation: ViewExpecatations) {
        self.expecatation = expecatation
    }
    
    func playerPlaced(with message: String) {
        self.expecatation.didCallGameInProgress.fulfill()
    }
    
    func gameDraw(with message: String) {
        self.expecatation.didCallDraw.fulfill()
    }
    
    func win(with message: String) {
        self.expecatation.didCallWin.fulfill()
    }
    
    func error(with message: String) {
        self.expecatation.didCallError.fulfill()
    }
}

struct BindExpecatations: ViewExpecatations {
    
    var didCallGameInProgress = XCTestExpectation()
    var didCallDraw = XCTestExpectation()
    var didCallWin = XCTestExpectation()
    var didCallError = XCTestExpectation()
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
