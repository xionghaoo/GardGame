//
//  Card.swift
//  CardGame
//
//  Created by xionghao on 2019/8/2.
//  Copyright © 2019 xionghao. All rights reserved.
//

import Foundation

// 实现HashTable Protocol
struct Card: Hashable {
    
    // left hand side and right hand side
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
//    static let UP = 0
//    static let DOWN = 1
//    static let DISAPPEAR = 2
    
    var id: Int
//    var status: Int = Card.DOWN
    var position: Int = 0
    var isMatched = false
    
    var isFaceUp = false
    
    private static var uniqueId = -1
    
    init() {
        id = Card.generateUniqueId()
    }
    
    private static func generateUniqueId() -> Int {
        uniqueId += 1
        return uniqueId
    }
    
}
