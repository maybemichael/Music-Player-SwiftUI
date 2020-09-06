//
//  ContentView.swift
//  Neu-Music-Playuer
//
//  Created by Michael McGrath on 9/6/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // This will hold every view on top of the background gradient
            VStack {
                HStack {
                    GradientButton(imageName: "arrow.left")
                        .padding(.leading, 30)
                    Spacer()
                    Text("PLAYING NOW")
                        .foregroundColor(.buttonColor)
                        .font(Font.system(.headline)
                            .smallCaps())
                    
                    
                    Spacer()
                    GradientButton(imageName: "line.horizontal.3")
                        .padding(.trailing, 30)
                }
                Spacer()
                
                PlayPauseButton()
                    .frame(width: 75, height: 75)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlayPauseButton: View {
    
    @State var isPlaying = false
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
        }) {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: colorsForIsPlaying()), startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: colorsForIsPlaying()), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .padding(2)
                
                Image(systemName: isPlaying ? "pause" : "play.fill")
                    .foregroundColor(.white)
                    .font(Font.system(.callout).weight(.black))
                
            }
        }
    }
    
    func colorsForIsPlaying() -> [Color] {
        if isPlaying {
            return [.pauseLightOrange, .pauseDarkOrange]
        } else {
            return [.playLightGreen, .playDarkGreen]
        }
    }
}

struct GradientButton: View {
    
    var imageName: String
    
    var body: some View {
        Button(action: {
            // TODO: - Add the back navigation later
        }) {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Image(systemName: imageName)
                    .resizable()
                    .font(Font.system(.headline).weight(.semibold))
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.buttonColor)
                    .frame(width: 23, height: 23)
                    .padding(13)
                    .background(LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
            }
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
        }
    }
}


