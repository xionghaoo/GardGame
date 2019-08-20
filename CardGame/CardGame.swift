//
//  CardGame.swift
//  CardGame
//
//  Created by xionghao on 2019/8/2.
//  Copyright © 2019 xionghao. All rights reserved.
//

import Foundation

class CardGame {
    private(set) var cards = [Card]()
    var copyCards = [Card]()
    var newCards = [Card]()
    
    var hasOneCardNoMatched: Bool? = nil
    var lastSelectCard = -1
    
    private(set) var flipCount = 0
    
    // 唯一一张面朝上的卡片
    private var indexOfOnlyOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            if let v = newValue {
                // 只处理indexOfOnlyOneFaceUpCard有值的情况
                for index in cards.indices {
                    cards[index].isFaceUp = ( index == v )
                }
            }
        }
    }
    
    init(cardNumber: Int) {
        for _ in 1...cardNumber {
            let card = Card()
            cards += [card, card]
        }
        // 洗牌
        copyCards = cards
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(copyCards.count)))
            newCards.append(copyCards.remove(at: randomIndex))
        }
        cards = newCards
    }
    
    func chooseCard(at index: Int) {
        // 过滤已匹配（隐藏）的卡片
        if cards[index].isMatched {
            return
        }
        flipCount += 1
        if let matchIndex = indexOfOnlyOneFaceUpCard, matchIndex != index {
            // 如果选择的卡片和现在正面朝上的卡片不是一张卡
            if (cards[matchIndex] == cards[index]) {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfOnlyOneFaceUpCard = nil
        } else {
            // 如果现在没有卡片朝上或者两张卡片朝上 indexOfOnlyOneFaceUpCard = nil
            indexOfOnlyOneFaceUpCard = index
        }
        
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
