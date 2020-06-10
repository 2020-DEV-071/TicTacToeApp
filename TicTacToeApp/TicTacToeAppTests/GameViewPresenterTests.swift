
import XCTest
@testable import TicTacToeApp

class GameViewControllerMock: ViewPresenter {
    
    var expecatation: XCTestExpectation!
    
    init(with expecatation: XCTestExpectation) {
        self.expecatation = expecatation
    }
    
    func moveResult(message: String) {
        self.expecatation.fulfill()
    }
    
}

class GameViewPresenterTests: XCTestCase {
    
    var presenter: GameViewPresenter!
    var expecatation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        self.expecatation = XCTestExpectation(description: "Playing")
        self.presenter = GameViewPresenter(with: GameViewControllerMock(with: self.expecatation))
    }
    
    override func tearDown() {
        self.presenter = nil
        super.tearDown()
    }
    
    func test_didSelectItem_returnsGameStatus() {
        
        let indexPath = IndexPath(row: 1, section: 1)
        self.presenter.didSelect(at: indexPath)
        self.wait(for: [self.expecatation], timeout: 2)
    }
}
