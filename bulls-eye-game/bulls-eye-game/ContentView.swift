//
//  ContentView.swift
//  bulls-eye-game
//
//  Created by Iqrah Nadeem on 16/07/2020.
//  Copyright © 2020 Iqrah Nadeem. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    
    let backgroundRed = Color(red: 238/255, green: 91/255, blue: 69/255)
    
    @State var score = 0
    @State var round = 1
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .font(Font.custom("Helvetica ", size: 28))
        }
    }
    
    struct ValueStyle:ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Helvetica ", size: 32))
        }
    }
    
    struct ButtonStyle:ViewModifier {
           func body(content: Content) -> some View {
               return content
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .font(Font.custom("Helvetica ", size: 28))
                    .cornerRadius(40)
           }
       }
    
    var body: some View {
        
        ZStack{
            
            backgroundRed
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                    Spacer()
                    
                    
                    //Target Message Row
                    HStack{
                        
                        Text("Target Value: ").modifier(LabelStyle())
                            
                        Text("\(targetValue)").modifier(ValueStyle())
                    }
                    Spacer()
                    
                    
                    //Slider Row
                    HStack{
                        Text("0").modifier(LabelStyle())
                        Slider(value: $sliderValue, in: 0...100).accentColor(Color.yellow)
                        Text("100").modifier(LabelStyle())
                    }.padding(.all)
                    
                    
                    
                    //Hit Me Button Row
                    Button(action: {
                        self.alertIsVisible = true
                    }) {
                        Text("Hit Me!")
                    }
                    .alert(isPresented: $alertIsVisible) { () -> Alert in
                        return Alert(title: Text(alertTitleMessage()), message: Text("The slider's value is \(usableSliderValue())\n" +
                            
                            "You scored \(calculateScore()) points in this round"), dismissButton: .default(Text("Okay")){
                                self.score += self.calculateScore()
                                self.targetValue = Int.random(in: 1...100)
                                self.round += 1
                            })

                    }.modifier(ButtonStyle())
                    
                    Spacer()
                    
                    
                    //Bottom Row
                    HStack{
                        //Start Over Button
                        Button(action: {
                            
                            self.startOver()
                            
                        }) {
                            
                            HStack{
                                Image("StartOverIcon")
                                Text("Start Over")
                                
                            }
                            
                        }
                        .modifier(ButtonStyle())
                        
                        Spacer()
                        //Score
                        Text("Score:")
                        Text("\(score)").modifier(ValueStyle())
                    
                        Spacer()
                        
                        //Round
                        Text("Round:")
                        Text("\(round)").modifier(ValueStyle())
                        
                        Spacer()
                        //Info Button
                        NavigationLink(destination: AboutView()) {
                            HStack{
                                Image("InfoIcon")
                                Text("Info")
                                
                            }
                        }
                        .foregroundColor(Color.blue)
                        .modifier(ButtonStyle())
                        
                    }.padding(.bottom)
                    .modifier(LabelStyle())
                }
        }
          .navigationBarTitle("🎯 Bull's Eye 🎯")
        }
        
        
    
    func usableSliderValue() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func targetDifference() -> Int {
        return abs(targetValue - usableSliderValue())
    }
    
    func calculateScore() -> Int {
        
        let awardedPoints = 100 - targetDifference()
        
        if targetDifference()==0{
            return awardedPoints + 100
        }
        
        else if targetDifference() == 1{
            return awardedPoints + 50
        }
        
        return awardedPoints
        
    }
    
    func alertTitleMessage() -> String {
        let difference = targetDifference()
        let titleMessage: String
        
        if difference == 0 {
            titleMessage = "Bull's Eye!"
        }
        else if difference < 5{
            titleMessage = "You almost had it!"
        }
        else if difference < 20{
            titleMessage = "Good try"
        }
        else{
            titleMessage = "Are you even trying?"
        }
        
        return titleMessage
        
    }
    
    func startOver() {
        
        score = 0
        round = 1
        sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
