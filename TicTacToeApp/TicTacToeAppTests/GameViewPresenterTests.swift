
import XCTest
@testable import TicTacToeApp

protocol ViewExpecatations {
    
    var inProgress: XCTestExpectation { get }
    var draw: XCTestExpectation{ get }
}

class GameViewControllerMock: ViewPresenter {
    
    var expecatation: ViewExpecatations!
    
    init(with expecatation: ViewExpecatations) {
        self.expecatation = expecatation
    }
    
    func playerPlaced(with message: String) {
        self.expecatation.inProgress.fulfill()
    }
    
    func gameEnd(with message: String) {
        self.expecatation.draw.fulfill()
    }
}

struct BindExpecatations: ViewExpecatations {
    
    var inProgress = XCTestExpectation()
    var draw = XCTestExpectation()
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
    
    static let r100c100 = Position(row: 100, coloumn: 100)
}



class GameViewPresenterTests: XCTestCase {
    
    var presenter: GameViewPresenter!
    let expec = BindExpecatations()
    
    override func setUp() {
        super.setUp()
        
        self.presenter = GameViewPresenter(with: GameViewControllerMock(with: expec))
        
    }
    
    override func tearDown() {
        self.presenter = nil
        super.tearDown()
    }
    
    func test_didSelectItem_returnsGameStatus() {
        
        
        let indexPath = IndexPath(row: 1, section: 1)
        self.presenter.didSelect(at: indexPath)
        self.wait(for: [expec.inProgress], timeout: 2)
    }
    
    func test_didSelectItemPlaceAllSquares_returnsGameDraw() {
        
        self.presenter.didSelect(at: IndexPaths.r0c0)
        self.presenter.didSelect(at: IndexPaths.r1c0)
        self.presenter.didSelect(at: IndexPaths.r2c0)
        self.presenter.didSelect(at: IndexPaths.r0c1)
        self.presenter.didSelect(at: IndexPaths.r0c2)
        self.presenter.didSelect(at: IndexPaths.r1c1)
        self.presenter.didSelect(at: IndexPaths.r1c2)
        self.presenter.didSelect(at: IndexPaths.r2c2)
        self.presenter.didSelect(at: IndexPaths.r2c1)
        
        self.wait(for: [expec.draw], timeout: 2)
    }
}
