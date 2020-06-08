
import XCTest
@testable import TicTacToeApp

enum Positions {
    
    static let r0c0 = Position(row: 0, coloumn: 0)
    static let r0c1 = Position(row: 0, coloumn: 1)
    static let r0c2 = Position(row: 0, coloumn: 2)
    
    static let r1c0 = Position(row: 1, coloumn: 0)
    static let r1c1 = Position(row: 1, coloumn: 1)
    static let r1c2 = Position(row: 1, coloumn: 2)
    
    static let r2c0 = Position(row: 2, coloumn: 0)
    static let r2c1 = Position(row: 2, coloumn: 1)
    static let r2c2 = Position(row: 2, coloumn: 2)
}

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
        
        XCTAssertNoThrow(try self.game.place(player: playerX, at: Positions.r0c0))
    }
    
    func test_unfilledSquaresAfterPlacingFirstPlayer_returnsExpectedCount() {
        
        try! self.game.place(player: .x, at: Positions.r0c0)
        let unfilledSqaures = self.game.gameBoard.unfilledSquares
        
        XCTAssertEqual(unfilledSqaures, 8)
    }
    
    func test_playerAtPosition_returnsPlacedPlayer() {
        
        try! self.game.place(player: .x, at: Positions.r0c0)
        let player = self.game.gameBoard.player(at: Positions.r0c0)
        
        XCTAssertEqual(player, Player.x)
    }
    
    func test_oPlayerGoesFirst_throwsError() {
        
        XCTAssertThrowsError(try self.game.place(player: .o, at: Positions.r0c0)) { error in
            XCTAssertEqual(error as! GameError, GameError.playerXShouldMoveFirst(message: "X should always goes first"))
        }
    }
    
    func test_playerPlaceTwiceInSequence_throwsError() {
        
        try! self.game.place(player: .x, at: Positions.r0c0)
        
        XCTAssertThrowsError(try self.game.place(player: .x, at: Positions.r0c1)) { error in
            XCTAssertEqual(error as! GameError, GameError.samePlayerPlayedAgain(message: "Same player played again"))
        }
    }
}
