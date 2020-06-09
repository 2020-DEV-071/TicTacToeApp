
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
    
    static let r100c100 = Position(row: 100, coloumn: 100)
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
    
    func test_unfilledSquaresBeforeStart_returnsExpectedCount() {
        
        let unfilledSquares = self.game.gameBoard.unfilledSquares
        XCTAssertEqual(unfilledSquares, 9)
    }
    
    func test_playerXGoesFirst_throwsNoError() {
        
        XCTAssertNoThrow(try self.game.place(player: .x, at: Positions.r0c0))
    }
    
    func test_playerOGoesFirst_throwsError() {
        
        XCTAssertThrowsError(try self.game.place(player: .o, at: Positions.r0c0)) { error in
            XCTAssertEqual(error as! GameError, GameError.playerXShouldMoveFirst(message: GameConstants.invalidFirstPlayer))
        }
    }
    
    func test_unfilledSquaresAfterPlacingFirstPlayer_returnsExpectedCount() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let unfilledSqaures = self.game.gameBoard.unfilledSquares
        
        XCTAssertEqual(unfilledSqaures, 8)
    }
    
    func test_playerAtPosition_returnsPlacedPlayer() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let player = try! self.game.gameBoard.player(at: Positions.r0c0)
        
        XCTAssertEqual(player, Player.x)
    }
    
    func test_playerPlaceTwiceInSequence_throwsError() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        
        XCTAssertThrowsError(try self.game.place(player: .x, at: Positions.r0c1)) { error in
            XCTAssertEqual(error as! GameError, GameError.samePlayerPlayedAgain(message: GameConstants.playerPlayedTwice))
        }
    }
    
    func test_playerPlacedOnPlayedPosition_throwsError() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c1)
        
        XCTAssertThrowsError(try self.game.place(player: .x, at: Positions.r0c1)) { error in
            XCTAssertEqual(error as! GameError, GameError.positionAlreadyPlayed(message: GameConstants.positionPlayed))
        }
    }
    
    func test_playerPlaceOutOfRangePosition_throwsError() {
        
        XCTAssertThrowsError(try self.game.place(player: .x, at: Positions.r100c100)) { error in
            XCTAssertEqual(error as! GameError, GameError.positionOutOfRange(message: GameConstants.invalidPosition))
        }
    }
    
    func test_fillAllPositionsWithoutFormingRows_returnsDraw() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r1c0)
        let _ = try! self.game.place(player: .x, at: Positions.r2c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c1)
        let _ = try! self.game.place(player: .x, at: Positions.r0c2)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let _ = try! self.game.place(player: .x, at: Positions.r1c2)
        let _ = try! self.game.place(player: .o, at: Positions.r2c2)
        let drawResult = try! self.game.place(player: .x, at: Positions.r2c1)
        
        XCTAssertEqual(drawResult, GameResult.draw)
    }
    
    func test_placeXHorizontalInRow_returnsWinX() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r1c0)
        let _ = try! self.game.place(player: .x, at: Positions.r0c1)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let winX = try! self.game.place(player: .x, at: Positions.r0c2)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeOHorizontalInRow_returnsWinO() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r1c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c0)
        let _ = try! self.game.place(player: .x, at: Positions.r1c1)
        let _ = try! self.game.place(player: .o, at: Positions.r0c1)
        let _ = try! self.game.place(player: .x, at: Positions.r2c2)
        let winO = try! self.game.place(player: .o, at: Positions.r0c2)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placeXVerticalInRow_returnsWinX() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c1)
        let _ = try! self.game.place(player: .x, at: Positions.r1c0)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let winX = try! self.game.place(player: .x, at: Positions.r2c0)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeOVerticalInRow_returnsWinO() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c1)
        let _ = try! self.game.place(player: .o, at: Positions.r0c0)
        let _ = try! self.game.place(player: .x, at: Positions.r0c2)
        let _ = try! self.game.place(player: .o, at: Positions.r1c0)
        let _ = try! self.game.place(player: .x, at: Positions.r2c1)
        let winO = try! self.game.place(player: .o, at: Positions.r2c0)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placeXLeftDiagonallyInRow_returnsWinX() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c1)
        let _ = try! self.game.place(player: .x, at: Positions.r1c1)
        let _ = try! self.game.place(player: .o, at: Positions.r0c2)
        let winX = try! self.game.place(player: .x, at: Positions.r2c2)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeOLeftDiagonallyInRow_returnsWinO() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c1)
        let _ = try! self.game.place(player: .o, at: Positions.r0c0)
        let _ = try! self.game.place(player: .x, at: Positions.r0c2)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let _ = try! self.game.place(player: .x, at: Positions.r2c1)
        let winO = try! self.game.place(player: .o, at: Positions.r2c2)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placeXRightDiagonallyInRow_returnsWinX() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c2)
        let _ = try! self.game.place(player: .o, at: Positions.r0c1)
        let _ = try! self.game.place(player: .x, at: Positions.r1c1)
        let _ = try! self.game.place(player: .o, at: Positions.r0c0)
        let winX = try! self.game.place(player: .x, at: Positions.r2c0)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeORightDiagonallyInRow_returnsWinO() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c2)
        let _ = try! self.game.place(player: .x, at: Positions.r0c1)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let _ = try! self.game.place(player: .x, at: Positions.r1c0)
        let winO = try! self.game.place(player: .o, at: Positions.r2c0)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placePlayersForIncmpleteGame_returnsGameInProgress() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c2)
        let _ = try! self.game.place(player: .x, at: Positions.r0c1)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let inProgress = try! self.game.place(player: .x, at: Positions.r2c2)
        
        XCTAssertEqual(inProgress, GameResult.inProgress)
    }
    
    func test_placeOAgainWhenPreviousMoveNotPlaced_throwsNoError() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try? self.game.place(player: .o, at: Positions.r0c0)
        
        XCTAssertNoThrow(try self.game.place(player: .o, at: Positions.r1c1))
    }
    
    func test_placePlayerAfterGameComplete_throwsError() {
        
        let _ = try! self.game.place(player: .x, at: Positions.r0c0)
        let _ = try! self.game.place(player: .o, at: Positions.r0c2)
        let _ = try! self.game.place(player: .x, at: Positions.r0c1)
        let _ = try! self.game.place(player: .o, at: Positions.r1c1)
        let _ = try! self.game.place(player: .x, at: Positions.r1c0)
        let _ = try! self.game.place(player: .o, at: Positions.r2c0)
        
        XCTAssertThrowsError(try self.game.place(player: .x, at: Positions.r2c2)) { error in
            XCTAssertEqual(error as! GameError, GameError.gameEnd(message: GameConstants.gameEnd))
        }
    }
    
    func test_placePlayerBydefault_movesXFirst() {
        
        let _ = try! self.game.place(at: Positions.r1c1)
        let playerX = try! self.game.gameBoard.player(at: Positions.r1c1)
        
        XCTAssertEqual(playerX, Player.x)
    }
}
