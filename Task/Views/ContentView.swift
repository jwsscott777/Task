//
//  ContentView.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
   
    private var items: FetchedResults<Item>
    
    @State private var showingSettingsView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false

    @State private var animate = false

   // @ObservedObject var theme = ThemeSettings()
    @EnvironmentObject var theme: ThemeSettings
    var themes: [Theme] = themeData

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(items, id: \.self) { item in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(colorize(priority: item.priority ?? "Carne"))
                            Text(item.name ?? "🐶")
                                .fontWeight(.semibold)
                            Spacer()
                            
                            Text(item.priority ?? "🥑")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                
                        }//:Hstack
                        .padding(.vertical, 10)
                    }//:ForEach
                    .onDelete(perform: deleteItem)
                }//:list
                .navigationBarTitle("Lista", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton().accentColor(themes[theme.themeSettings].themeColor),
                    trailing:
                                        Button(action: {
                                            showingSettingsView.toggle()
                                        }) {
                                            Image(systemName: "wrench")
                                                .imageScale(.large)
                                        }//:addbutton
                        .accentColor(themes[theme.themeSettings].themeColor)
                                        .sheet(isPresented: $showingSettingsView) {
                                           SettingsView()
                                        }
            )
                //mark no items
                if items.count == 0 {
                    EmptyListView()
                }
            }//:zstack
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, viewContext)
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[theme.themeSettings].themeColor)
                            .opacity(animatingButton ? 0.2 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[theme.themeSettings].themeColor)
                            .opacity(animatingButton ? 0.15 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }//:Group
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            animate.toggle()
                        }
                    }

                    
                    Button(action: {
                        showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    }//:button
                    .accentColor(themes[theme.themeSettings].themeColor)
                   .onAppear(perform: {
                        animatingButton.toggle()
                    })
                }//:zstack
                .padding(.bottom, 15)
                .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        }//:nav
    }
    //functions
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            viewContext.delete(item)
            
            do {
               try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "Lecheria":
            return .blue
        case "Carne":
            return .pink
        case "Veg":
            return .green
        case "Outro":
            return .purple
        default:
            return .gray
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
