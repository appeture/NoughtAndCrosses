//
//  ViewController.swift
//  NoughtAndCrosses
//
//  Created by Romanovich Bogdan on 27.03.2021.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var fieldsButtonCollection: [UIButton]!
  @IBOutlet weak var winnerLabel: UILabel!
  @IBOutlet weak var resetButtonOutlet: UIButton!
  
  private var noughtSet  = Set<Int>()
  private var crossesSet = Set<Int>()
  private var moveCrosses = Bool.random()
  private var pressedButtonCounter = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    resetButtonOutlet.layer.cornerRadius = 10
    whoMove(moveCrosses: moveCrosses)
  }
  
  @IBAction func fieldsButtonPressed(_ sender: Any) {
    let button = sender as! UIButton
    
    if moveCrosses {
      fieldsButtonCollection[button.tag - 1].setTitle("X", for: .normal)
      crossesSet.insert(button.tag)
    } else {
      fieldsButtonCollection[button.tag - 1].setTitle("O", for: .normal)
      noughtSet.insert(button.tag)
    }
    
    if winnerCheck(check: crossesSet) {
      winnerLabel.text = "X Winner"
      for button in fieldsButtonCollection {
        button.isEnabled = false
      }
      return
    }
    
    if winnerCheck(check: noughtSet) {
      winnerLabel.text = "O Winner"
      for button in fieldsButtonCollection {
        button.isEnabled = false
      }
      return
    }
    
    
    
    moveCrosses.toggle()
    whoMove(moveCrosses: moveCrosses)
    button.isEnabled = false
    pressedButtonCounter += 1
    if pressedButtonCounter == 9 {
      winnerLabel.text = "Draw"
    }
    
  }
  
  
  @IBAction func resetButton(_ sender: Any) {
    for button in fieldsButtonCollection {
      button.isEnabled = true
      button.setTitle("", for: .normal)
    }
    
    noughtSet = []
    crossesSet = []
    pressedButtonCounter = 0
    winnerLabel.text = ""
    moveCrosses = Bool.random()
    whoMove(moveCrosses: moveCrosses)
  }
  
  private func whoMove(moveCrosses: Bool) {
    if moveCrosses {
      winnerLabel.text = "move X"
    } else {
      winnerLabel.text = "move O"
    }
  }
  
  private func winnerCheck(check set: Set<Int>) -> Bool {
    let winnerArray = [[1,2,3], [4,5,6], [7,8,9],
                       [1,4,7], [2,5,8], [3,6,9],
                       [3,5,7], [1,5,9]]
    var isWin = false
    var subtractingSet = Set<Int>()
    if set.count >= 3 {
      
      for winCombination in winnerArray {
        subtractingSet = Set(winCombination).subtracting(set)
        if subtractingSet.count == 0 {
          isWin.toggle()
        }
      }
    }
    
    return isWin
  }
}

