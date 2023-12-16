//
//  SettingsView.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI

struct SettingsView: View {
    //properties
    @Environment(\.presentationMode) var presentationMode
    
    //theme
    
    let themes: [Theme] = themeData
    @EnvironmentObject var theme: ThemeSettings
   // @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged: Bool = false
    //body
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0.0) {
                Form {
                    //mark section 2
                    Section(header:
                                HStack {
                                    Text("Pick a theme")
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(themes[theme.themeSettings].themeColor)
                                }//: hstack
                    ) {
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    theme.themeSettings = item.id
                                    isThemeChanged.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        
                                        Text(item.themeName)
                                    }
                                }//: button
                                .accentColor(Color.primary)
                                
                            }
                        }
                    }//: sec2
                    .alert(isPresented: $isThemeChanged) {
                        Alert(
                        title: Text("Perfecto!"),
                            message: Text("Color has been changed. Restart the App"),
                            dismissButton: .default(Text("Okay"))
                        )
                    }
                    
                    //mark section 3
                    Section(header: Text("Check out my YouTube")) {
                        FormRowLinkView(icon: "globe", color: .pink, text: "YouTube", link: "https://www.youtube.com/channel/UCMAqKAcrn58dmqg0N6Qm2Hw?view_as=subscriber")
                        FormRowLinkView(icon: "swift", color: .blue, text: "Aldi", link: "https://www.aldi.us/")
                        FormRowLinkView(icon: "bag.circle", color: .green, text: "Publix", link: "https://www.publix.com/?utm_medium=organic&utm_source=google&utm_term=google_my_business")
                        FormRowLinkView(icon: "building", color: .purple, text: "Walmart", link: "https://www.walmart.com/store/1916-coconut-creek-fl")
                    }//: sec 3
                    
                    // mark section 4
                    Section(header: Text("About the Application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Lista")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatible", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "James Scott")
                        FormRowStaticView(icon: "wrench", firstText: "Designer", secondText: "James Scott")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.2.2")
                    }//: sec 4
                    .padding(.vertical, 3)
                }//:form
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                //mark footer
                Text("Copyright 🇨🇴 2024 🐶")
                    .font(.footnote)
                    .padding(.bottom, 6)
                    .padding(.top, 6)
                    .foregroundColor(Color.secondary)
               
            }//:vstack
            .navigationBarItems(trailing:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                    }
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground"))
            .edgesIgnoringSafeArea(.all)
        }//: Nav
        .accentColor(themes[theme.themeSettings].themeColor)
    }
}

#Preview {
    SettingsView()
}
