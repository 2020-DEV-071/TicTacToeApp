
enum GameError: Error, Equatable {
    
    case playerXShouldMoveFirst(message: String)
    case samePlayerPlayedAgain(message: String)
    case positionAlreadyPlayed(message: String)

}
