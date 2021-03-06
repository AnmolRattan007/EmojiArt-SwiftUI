//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by anmol rattan on 17/05/21.
//

import SwiftUI

class EmojiArtDocument: ObservableObject{
    
    static let pallete = "🦑🐃🐥🐴🐝"
    
    @Published private var emojiArt:EmojiArt = EmojiArt()
    
    @Published private(set) var backgroundImage:UIImage?
    
    var emojis:[EmojiArt.Emoji]{
        emojiArt.emojis
    }
    
    //Intent:
    
    func addEmoji(emoji:String,at location:CGPoint, size:CGFloat){
        emojiArt.addEmoji(emoji: emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(emoji:EmojiArt.Emoji,by offset:CGSize){
        if let index = emojiArt.emojis.firstIndex(matching:emoji){
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
        
    }
    
    func scaleEmoji(emoji:EmojiArt.Emoji,by scale:CGFloat){
        if let index = emojiArt.emojis.firstIndex(matching:emoji){
            emojiArt.emojis[index].size = Int(scale)
            
        }
    }
    
    func setBackgroundURL(_ url:URL?){
        emojiArt.backgroundURL = url?.imageURL
        self.fetchBackGroundImage()
    }
    
    private func fetchBackGroundImage(){
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL{
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf:url){
                    DispatchQueue.main.async {
                        if  url == self.emojiArt.backgroundURL{
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
}

extension EmojiArt.Emoji{
    var fontSize:CGFloat{
        CGFloat(self.size)
    }
    var location:CGPoint{
        CGPoint(x:CGFloat(x),y:CGFloat(y))
    }
}


