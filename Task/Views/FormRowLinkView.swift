//
//  FormRowLinkView.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI

struct FormRowLinkView: View {
    //properties
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    //body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }//:zstack
            .frame(width: 36, height: 36, alignment: .center)
            Text(text).foregroundColor(Color.gray)
            Spacer()
            
            Button(action: {
                //link
                guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url as URL)
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }//:hstack
    }
}
//preview
#Preview {
    FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://www.youtube.com/channel/UCMAqKAcrn58dmqg0N6Qm2Hw?view_as=subscriber")
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
}
