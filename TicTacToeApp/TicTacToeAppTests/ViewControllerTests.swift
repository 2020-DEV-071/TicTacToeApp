//
//  ViewControllerTests.swift
//  TicTacToeAppTests
//
//  Created by Raja Manikanta Diddi on 09/06/2020.
//

import XCTest
@testable import TicTacToeApp

class ViewControllerTests: XCTestCase {

    var gameViewController: ViewController!
    
    override func setUp() {
        
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.gameViewController = storyboard.instantiateViewController(identifier: "ViewController")
    }

    override func tearDown() {
        
        self.gameViewController = nil
        super.tearDown()
    }
    
    func test_collectionViewIsNotNil_afterViewDidLoad() {
        
        self.gameViewController.loadViewIfNeeded()
        XCTAssertNotNil(self.gameViewController.collectionView)
    }
}
