//
//  AboutView.swift
//  bulls-eye-game
//
//  Created by Iqrah Nadeem on 17/07/2020.
//  Copyright © 2020 Iqrah Nadeem. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let backgroundRed = Color(red: 245/255, green: 151/255, blue: 136/255)
    
    struct HeadingStyle: ViewModifier {
           func body(content: Content) -> some View {
               return content
                .foregroundColor(Color.black)
                .font(Font.custom("Helvetica ", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
           }
       }
    
    
    struct textStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
             .foregroundColor(Color.black)
             .font(Font.custom("Helvetica ", size: 16))
             .padding(.leading, 60)
             .padding(.trailing, 60)
             .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        
        ZStack{
            
            backgroundRed
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("🎯 Bull's Eye 🎯").modifier(HeadingStyle())
                VStack{
                Text("This is a fun little slider game to test your accuracy.")
                Text("Your goal is to place the slider as close to the target value.")
                Text("The closer you are, the more points you win!")
                }.modifier(HeadingStyle())
            }
            
        }
        
        
        .navigationBarTitle("About Bull's Eye")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
