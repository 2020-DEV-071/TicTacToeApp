
enum GameError: Error, Equatable {
    
    case positionAlreadyPlayed(message: String)
    case positionOutOfRange(message: String)
    case gameEnd(message: String)
}
