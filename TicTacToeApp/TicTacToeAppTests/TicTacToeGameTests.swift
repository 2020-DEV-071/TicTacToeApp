
import XCTest
@testable import TicTacToeApp

class TicTacToeGameTests: XCTestCase {
    
    var game: TicTacToeGame!
    
    override func setUp() {
        self.game = TicTacToeGame()
    }
    
    override func tearDown() {
        self.game = nil
    }
    
    func test_numberOfPlayers_returnsTwo() {
        
        let playersCount = self.game.numberOfPlayers
        XCTAssertEqual(playersCount, 2)
    }
    
    func test_firtPlayer_returnsX() {
        
        let firstPlayer = self.game.firstPlayer!
        XCTAssertEqual(firstPlayer.rawValue, "X")
    }
    
    func test_secondPlayer_returnsO() {
        
        let secondPlayer = self.game.secondPlayer!
        XCTAssertEqual(secondPlayer.rawValue, "O")
    }
}