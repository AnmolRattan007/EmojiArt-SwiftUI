//
//  ContentView.swift
//  EmojiArt
//
//  Created by anmol rattan on 17/05/21.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document:EmojiArtDocument
    
    var body: some View {
        
        VStack{
            
            ScrollView(.horizontal){
                HStack{
                    
                    ForEach(EmojiArtDocument.pallete.map{String($0)},id:\.self){ emoji in
                        Text(emoji)
                            .font(Font.system(size: defaultEmojiSize))
                            .onDrag{return NSItemProvider(object: emoji as NSString)}
                    }
                    
                }
                
            }.padding(.horizontal)
            
            
            GeometryReader{ geometry in
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.white).overlay(
                            Group{
                                if self.document.backgroundImage != nil{
                                    Image(uiImage: self.document.backgroundImage!)
                                }
                                
                            }
                            
                        )
                        .edgesIgnoringSafeArea([.horizontal,.bottom])
                        .onDrop(of: ["public.image","public.text"], isTargeted: nil){ providers,location in
                            
                            var location = geometry.convert(location,from: .global)
                            location = CGPoint(x:location.x-geometry.size.width/2,y:location.y-geometry.size.height/2)
                            return self.drop(providers: providers,at: location)
                        }
                    
                    

                }
                
            }
            
        }
        
        
        
    }
    private func drop(providers:[NSItemProvider],at location:CGPoint)->Bool{
        
        var found = providers.loadFirstObject(ofType: URL.self){url in
            print("Dropped:\(url)")
            self.document.setBackgroundURL(url)
        }
        if !found{
            found = providers.loadObjects(ofType: String.self){ string in
                
                self.document.addEmoji(emoji: string, at: location, size: defaultEmojiSize)
            }
        }
        
        return found
    }
    
    private var defaultEmojiSize:CGFloat{
        40
    }
}

