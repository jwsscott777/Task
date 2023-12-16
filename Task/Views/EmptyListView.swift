//
//  EmptyListView.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI

struct EmptyListView: View {
    @State private var isAnimated: Bool = false
    
    let images: [String] = [
    "drinking", "pushing", "floating"
    ]
    
    let tips: [String] = [
    "Stay away from cockroaches", "Good Grief This is Madness", "Believe in Myself", "Where is my Mind today?", "I am Amazing!"
    ]
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20.0) {
                Image("\(images.randomElement() ?? images[0])")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                
                Text("\(tips.randomElement() ?? tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(themes[theme.themeSettings].themeColor)
            }//:vstack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .onAppear(perform: {
                withAnimation(Animation.easeOut(duration: 1.5)) {
                    isAnimated.toggle()
                }
            })
        }//:Zstack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    EmptyListView()
}
