//
//  SearchView.swift
//  Neu-Music-Playuer
//
//  Created by Michael McGrath on 9/7/20.
//  Copyright © 2020 Michael McGrath. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.bgGradientTop, .bgGradientBottom]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
