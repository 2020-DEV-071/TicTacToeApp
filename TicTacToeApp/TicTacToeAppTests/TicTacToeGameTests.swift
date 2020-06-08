
import XCTest
@testable import TicTacToeApp

class TicTacToeGameTests: XCTestCase {
    
    var game: TicTacToeGame!
    
    override func setUp() {
        super.setUp()
        self.game = TicTacToeGame()
    }
    
    override func tearDown() {
        self.game = nil
        super.tearDown()
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
    
    func test_unfilledSquaresBeforeStart_returnsExpectedCount() {
        
        let unfilledSquares = self.game.gameBoard.unfilledSquares
        XCTAssertEqual(unfilledSquares, 9)
    }
    
    func test_xPlayerGoesFirst_throwsNoError() {
        
        let playerX = game.firstPlayer!
        let row0Coloumn0 = Position(row: 0, coloumn: 0)
        
        XCTAssertNoThrow(try self.game.place(player: playerX, at: row0Coloumn0))
    }
    
    func test_unfilledSquaresAfterPlacingFirstPlayer_returnsExpectedCount() {
        
        let row0Coloumn0 = Position(row: 0, coloumn: 0)
        try! self.game.place(player: .x, at: row0Coloumn0)
        let unfilledSqaures = self.game.gameBoard.unfilledSquares
        
        XCTAssertEqual(unfilledSqaures, 8)
    }
    
    func test_playerAtPosition_returnsPlacedPlayer() {
        
        let row0Coloumn0 = Position(row: 0, coloumn: 0)
        try! self.game.place(player: .x, at: row0Coloumn0)
        let player = self.game.gameBoard.player(at: row0Coloumn0)
        
        XCTAssertEqual(player, Player.x)
    }
    
    func test_oPlayerGoesFirst_throwsError() {
        
        let row0Coloumn0 = Position(row: 0, coloumn: 0)
        
        XCTAssertThrowsError(try self.game.place(player: .o, at: row0Coloumn0)) { error in
            XCTAssertEqual(error as! GameError, GameError.playerXShouldMoveFirst(message: "X should always goes first"))
        }
    }
}
