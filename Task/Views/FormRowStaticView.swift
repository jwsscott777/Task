//
//  FormRowStaticView.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI

struct FormRowStaticView: View {
    //Properties
    var icon: String
    var firstText: String
    var secondText: String
    
    //body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }//:zstack
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

#Preview {
    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Lista")
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
}
