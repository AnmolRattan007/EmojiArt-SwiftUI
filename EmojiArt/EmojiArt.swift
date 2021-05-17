//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by anmol rattan on 17/05/21.
//

import Foundation


struct EmojiArt{
    
    var backgroundURL:URL?
    var emojis = [Emoji]()
    
    struct Emoji:Identifiable{
        let emoji:String
        var x:Int
        var y:Int
        var size:Int
        let id:Int
        
        fileprivate init(emoji:String,x:Int,y:Int,size:Int,id:Int){
            self.emoji = emoji
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(emoji:String,x:Int,y:Int,size:Int){
        uniqueEmojiId += 1
        emojis.append(Emoji(emoji: emoji, x: x, y: y, size: size, id: uniqueEmojiId))
    }
    
    
    
}
