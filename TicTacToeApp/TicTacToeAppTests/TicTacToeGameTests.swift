
import XCTest
@testable import TicTacToeApp

class TicTacToeGameTests: XCTestCase {
    
    var game: TicTacToeGame!
    
    override func setUp() {
        super.setUp()
        
        let winAnalyser = ResultAnalyser()
        self.game = TicTacToeGame(with: winAnalyser)
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
        
        XCTAssertNoThrow(try self.game.place(at: Positions.r0c0))
    }
    
    func test_playerOGoesFirst_throwsError() {
        
        XCTAssertThrowsError(try self.game.place(player: .o,
                                                 at: Positions.r0c0)) { error in
                                                    XCTAssertEqual(error as! GameError,
                                                                   GameError.playerXShouldMoveFirst(message: GameConstants.invalidFirstPlayer))
        }
    }
    
    func test_unfilledSquaresAfterPlacingFirstPlayer_returnsExpectedCount() {
        
        let _ = try! self.game.place(at: Positions.r0c0)
        let unfilledSqaures = self.game.gameBoard.unfilledSquares
        
        XCTAssertEqual(unfilledSqaures, 8)
    }
    
    func test_playerAtPosition_returnsPlacedPlayer() {
        
        let _ = try! self.game.place(at: Positions.r0c0)
        let player = try! self.game.gameBoard.player(at: Positions.r0c0)
        
        XCTAssertEqual(player, Player.x)
    }
    
    func test_playerPlaceTwiceInSequence_throwsError() {
        
        let _ = try! self.game.place(at: Positions.r0c0)
        
        XCTAssertThrowsError(try self.game.place(player: .x,
                                                 at: Positions.r0c1)) { error in
                                                    XCTAssertEqual(error as! GameError,
                                                                   GameError.samePlayerPlayedAgain(message: GameConstants.playerPlayedTwice))
        }
    }
    
    func test_playerPlacedOnPlayedPosition_throwsError() {
        
        let twoPositions = [Positions.r0c0,
                            Positions.r0c1]
        
        let _ = self.placePosition(at: twoPositions)
        
        XCTAssertThrowsError(try self.game.place(at: Positions.r0c1)) { error in
            XCTAssertEqual(error as! GameError,
                           GameError.positionAlreadyPlayed(message: GameConstants.positionPlayed))
        }
    }
    
    func test_playerPlaceOutOfRangePosition_throwsError() {
        
        XCTAssertThrowsError(try self.game.place(at: Positions.r100c100)) { error in
            XCTAssertEqual(error as! GameError,
                           GameError.positionOutOfRange(message: GameConstants.invalidPosition))
        }
    }
    
    func test_fillAllPositionsWithoutFormingRows_returnsDraw() {
        
        let drawPositions = [Positions.r0c0,
                             Positions.r1c0,
                             Positions.r2c0,
                             Positions.r0c1,
                             Positions.r0c2,
                             Positions.r1c1,
                             Positions.r1c2,
                             Positions.r2c2,
                             Positions.r2c1]
        
        let drawResult = self.placePosition(at: drawPositions)
        
        XCTAssertEqual(drawResult, GameResult.draw)
    }
    
    func test_placeXHorizontalInRow_returnsWinX() {
        
        let xWinPositions = [Positions.r0c0,
                             Positions.r1c0,
                             Positions.r0c1,
                             Positions.r1c1,
                             Positions.r0c2]
        
        let winX = self.placePosition(at: xWinPositions)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeOHorizontalInRow_returnsWinO() {
        
        let oWinPositions = [Positions.r1c0,
                             Positions.r0c0,
                             Positions.r1c1,
                             Positions.r0c1,
                             Positions.r2c2,
                             Positions.r0c2]
        
        let winO = self.placePosition(at: oWinPositions)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placeXVerticalInRow_returnsWinX() {
        
        let verticalRow = [Positions.r0c0,
                           Positions.r0c1,
                           Positions.r1c0,
                           Positions.r1c1,
                           Positions.r2c0]
        
        let winX = self.placePosition(at: verticalRow)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeOVerticalInRow_returnsWinO() {
        
        let verticalRow = [Positions.r0c1,
                           Positions.r0c0,
                           Positions.r0c2,
                           Positions.r1c0,
                           Positions.r2c1,
                           Positions.r2c0]
        
        let winO = self.placePosition(at: verticalRow)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placeXLeftDiagonallyInRow_returnsWinX() {
        
        let leftDiagonalRow = [Positions.r0c0,
                               Positions.r0c1,
                               Positions.r1c1,
                               Positions.r0c2,
                               Positions.r2c2]
        
        let winX = self.placePosition(at: leftDiagonalRow)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeOLeftDiagonallyInRow_returnsWinO() {
        
        let leftDiagonalRow = [Positions.r0c1,
                               Positions.r0c0,
                               Positions.r0c2,
                               Positions.r1c1,
                               Positions.r2c1,
                               Positions.r2c2]
        
        let winO = self.placePosition(at: leftDiagonalRow)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placeXRightDiagonallyInRow_returnsWinX() {
        
        let xWinPositions = [Positions.r0c2,
                             Positions.r0c1,
                             Positions.r1c1,
                             Positions.r0c0,
                             Positions.r2c0]
        
        let winX = self.placePosition(at: xWinPositions)
        
        XCTAssertEqual(winX, GameResult.win(player: .x))
    }
    
    func test_placeORightDiagonallyInRow_returnsWinO() {
        
        let rightDiagonalRow = [Positions.r0c0,
                                Positions.r0c2,
                                Positions.r0c1,
                                Positions.r1c1,
                                Positions.r1c0,
                                Positions.r2c0]
        
        let winO = self.placePosition(at: rightDiagonalRow)
        
        XCTAssertEqual(winO, GameResult.win(player: .o))
    }
    
    func test_placePlayersForIncmpleteGame_returnsGameInProgress() {
        
        let incompleteRow = [Positions.r0c0,
                             Positions.r0c2,
                             Positions.r0c1,
                             Positions.r1c1,
                             Positions.r2c2]
        
        let inProgressResult = self.placePosition(at: incompleteRow)
        
        XCTAssertEqual(inProgressResult, GameResult.inProgress)
    }
    
    func test_placeOAgainWhenPreviousMoveNotPlaced_throwsNoError() {
        
        let _ = try! self.game.place(at: Positions.r0c0)
        let _ = try? self.game.place(at: Positions.r0c0)
        
        XCTAssertNoThrow(try self.game.place(at: Positions.r1c1))
    }
    
    func test_placePlayerAfterGameComplete_throwsError() {
        
        let gamePositions = [Positions.r0c0,
                             Positions.r0c2,
                             Positions.r0c1,
                             Positions.r1c1,
                             Positions.r1c0,
                             Positions.r2c0]
        
        let _ = self.placePosition(at: gamePositions)
        
        XCTAssertThrowsError(try self.game.place(at: Positions.r2c2)) { error in
            XCTAssertEqual(error as! GameError,
                           GameError.gameEnd(message: GameConstants.gameEnd))
        }
    }
    
    func test_placePlayerBydefault_movesXFirst() {
        
        let _ = try! self.game.place(at: Positions.r1c1)
        let playerX = try! self.game.gameBoard.player(at: Positions.r1c1)
        
        XCTAssertEqual(playerX, Player.x)
    }
    
    func test_placePlayerSecondBydefault_movesOSecond() {
        
        let twoPositions = [Positions.r1c1,
                            Positions.r2c2]
        
        let _ = self.placePosition(at: twoPositions)
        let playerO = try! self.game.gameBoard.player(at: Positions.r2c2)
        
        XCTAssertEqual(playerO, Player.o)
    }
    
    func test_placeSamePlayerAfterError_returnsSamePlayerWithoutSwap() {
        
        let twoPositions = [Positions.r1c1,
                            Positions.r2c2]
        
        let _ = self.placePosition(at: twoPositions)
        let _ = try? self.game.place(at: Positions.r1c1)
        let _ = try! self.game.place(at: Positions.r0c0)
        let playerX = try! self.game.gameBoard.player(at: Positions.r0c0)
        
        XCTAssertEqual(playerX, Player.x)
    }
}

extension TicTacToeGameTests {
    
    private func placePosition(at positions: [Position]) -> GameResult {
        
        var result: GameResult!
        
        positions.forEach {
            result = try! self.game.place(at: $0)
        }
        return result
    }
}

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
