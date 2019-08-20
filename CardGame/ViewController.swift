//
//  ViewController.swift
//  CardGame
//
//  Created by xionghao on 2019/8/2.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

// MVC
// 数据驱动UI变化
// Model层完成逻辑，UI层负责显示
class ViewController: UIViewController {
    
    lazy var game: CardGame = CardGame(cardNumber: (cardButtons.count / 2) + 1)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let position = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: position)
            updateViewFromModel()
        } else {
            print("card not exist")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            // card数量大于等于button的数量
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: .normal)
            } else {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.7854272402, blue: 0.1517571501, alpha: 0) : #colorLiteral(red: 1, green: 0.7854272402, blue: 0.1517571501, alpha: 1)
                button.setTitle("", for: .normal)
            }
            
        }
        
        // 富文本
        let attributes: [NSAttributedString.Key:Any]? = [
            .strokeColor: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1),
            .strokeWidth: 5.0
        ]
        let attributeString = NSAttributedString(string: "Flip \(game.flipCount) times", attributes: attributes)
        flipCountLabel.attributedText = attributeString
    }

    
    // 映射emoji到card
    private var emojis = ["🤬", "👻", "👽", "💩", "🤦🏼‍♀️", "🧖‍♀️", "😇", "👀", "🐼"]
    private var emojiMap = [Card: String]()
    private func emoji(for card: Card) -> String {
        if emojiMap[card] == nil, emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emojiMap[card] = emojis.remove(at: randomIndex)
        }
        return emojiMap[card] ?? "?"
    }
    
}

