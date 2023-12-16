//
//  AddTodoView.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI

struct AddTodoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Carne"
    
    let priorities = ["Lecheria", "Carne", "Veg", "Outro"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 20.0) {
                    TextField("Entre Lista", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    //mark save button
                    Button(action: {
                        if self.name != "" {
                            let item = Item(context: viewContext)
                            item.name = name
                            item.priority = priority
                            
                            do {
                                try self.viewContext.save()
                            } catch {
                                print(error)
                            }
                        } else {
                            errorShowing = true
                            errorTitle = "Not Correcto"
                            errorMessage = "Enter a Lista Item Por Favor!"
                            return
                        }
                        presentationMode.wrappedValue.dismiss()
                       
                    }){
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[theme.themeSettings].themeColor)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                    }//:save buttom
                }//: VStack
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
                
            }//:vstack
            .navigationBarTitle("New Listas", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                        }
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Okay")))
            }
        }//:nav
        .accentColor(themes[theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    AddTodoView()
}
