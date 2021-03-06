//
//  ContentView.swift
//  Neu-Music-Playuer
//
//  Created by Michael McGrath on 9/6/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import SwiftUI

class Song: ObservableObject {
    let title: String
    let artist: String
    let duration: TimeInterval
    @Published var currentTime: TimeInterval
    let coverArt: UIImage
    
    init(title: String = "Drake", artist: String = "Hold On, We're Going Home ft. Majid Jordan", duration: TimeInterval = 120, image: UIImage = UIImage(named: "BurningFlower")!, currentTime: TimeInterval = 60) {
        self.title = title
        self.artist = artist
        self.duration = duration
        self.coverArt = image
        self.currentTime = currentTime
    }
}

struct ContentView: View {
    
    @ObservedObject var song = Song()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // This will hold every view on top of the background gradient
                VStack {
                    HStack {
                        GradientButton(imageName: "arrow.left", size: 50, symbolConfig: .navButtonConfig)
                            .padding(.leading, 30)
                        Spacer()
                        Text("PLAYING NOW")
                            .foregroundColor(.buttonColor)
                            .font(Font.system(.headline)
                                .smallCaps())
                        
                        
                        Spacer()
                        GradientButton(imageName: "line.horizontal.3", size: 50, symbolConfig: .navButtonConfig)
                            .padding(.trailing, 30)
                    }
                    CoverArtView(size: geometry.size.width * 0.87)
                        .padding(.top, 12)
                        .padding(.bottom, 30)
                    Text(self.song.title)
                        .font(Font.system(.largeTitle).weight(.medium))
                        .foregroundColor(.buttonColor)
                    Text(self.song.artist)
                        .font(Font.system(.callout))
                        .foregroundColor(.buttonColor)
                    
                    PlayerProgressView(song: self.song)
                        .padding(.top, 40)
                    Spacer()
                    
                    HStack {
                        Spacer()
                        GradientButton(imageName: "backward.fill", size: 70, symbolConfig: .playbackButtonConfig)
                        PlayPauseButton()
                            .frame(width: 75, height: 75)
                            .padding(.horizontal, 20)
                        GradientButton(imageName: "forward.fill", size: 70, symbolConfig: .playbackButtonConfig)
                        Spacer()
                    }
                }
                .padding(.bottom, 60)
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
    
    @State var isPlaying = true
    
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
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
        .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
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
    var size: CGFloat
    var symbolConfig: UIImage.SymbolConfiguration
    
    var body: some View {
        Button(action: {
            // TODO: - Add the back navigation later
        }) {
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Image(uiImage: UIImage(systemName: imageName, withConfiguration: symbolConfig)!)
                    .font(Font.system(.headline).weight(.semibold))
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.buttonColor)
                    .frame(width: size * 0.95, height: size * 0.95)
                    .background(LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
            }
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
        }
    }
}



struct CoverArtView: View {
    
    var size: CGFloat = 2755
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.bgGradientBottom.opacity(0.7))
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            Image("BurningFlower")
                .resizable()
                .font(Font.system(.headline).weight(.semibold))
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.buttonColor)
                .frame(width: size * 0.94, height: size * 0.94)
                .background(LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
        }
        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 25, y: 25)
        .shadow(color: Color.white.opacity(0.1), radius: 15, x: -15, y: -20)
    }
}

struct PlayerProgressView: View {
    
    @ObservedObject var song: Song
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "m:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var trackRadius: CGFloat = 3
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("\(formattedTimeFor(timeInterval: song.currentTime))")
                Spacer()
                Text("\(formattedTimeFor(timeInterval: song.duration))")
            }
            .foregroundColor(.buttonColor)
            .font(Font.system(.caption))
            
            ZStack {
                RoundedRectangle(cornerRadius: trackRadius)
                    .fill(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .bgGradientTop, location: 0.1), Gradient.Stop(color: Color.black.opacity(0.7), location: 0.8)]),
                                         startPoint: .bottom,
                                         endPoint: .top))
                    .frame(height: trackRadius * 2)
                GeometryReader { geometry in
                    HStack {
                        RoundedRectangle(cornerRadius: self.trackRadius)
                            .fill(LinearGradient(gradient: Gradient(colors: [.trackOrange,.trackYellow]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: geometry.size.width * self.percentagePlayedForSong(), height: self.trackRadius * 2)
                        Spacer()
                    }
                }
                GeometryReader { geometry in
                    HStack {
                        Circle()
                            .fill(RadialGradient(gradient: Gradient(stops:
                                [Gradient.Stop(color: .trackYellow, location: 0.0),
                                Gradient.Stop(color: .bgGradientBottom, location: 0.00001),
                                Gradient.Stop(color: .bgGradientTop, location: 1),]),
                                center: .center, startRadius: 6, endRadius: 40))
                            .frame(width: 40, height: 40)
                            .padding(.leading, geometry.size.width * self.percentagePlayedForSong() - 15)
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        self.song.currentTime = self.time(for: value.location.x, in: geometry.size.width)
                                    })
                        )
                        Spacer(minLength: 0)
                    }
                }
            }
            .frame(height: 40)
        }
        .padding(.horizontal, UIScreen.main.bounds.width * 0.07)
    }
    
    func formattedTimeFor(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        return dateFormatter.string(from: date)
    }
    
    func time(for location: CGFloat, in width: CGFloat) -> TimeInterval {
        let percentage = location / width
        let time = song.duration * TimeInterval(percentage)
        if time < 0 {
            return 0
        } else if time > song.duration {
            return song.duration
        }
        return time
    }
    
    func percentagePlayedForSong() -> CGFloat {
        CGFloat(song.currentTime / song.duration)
    }
}



//Circle()
//.fill(RadialGradient(gradient:
//    Gradient(stops: [Gradient.Stop(color: .trackYellow, location: 0.0),
//    Gradient.Stop(color: .bgGradientBottom, location: 0.000000000001),
//    Gradient.Stop(color: .bgGradientTop, location: 1)]),
//    center: .center, startRadius: 5, endRadius: 40))
//.frame(width: 40, height: 40)
//.padding(.leading, )
