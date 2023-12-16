//
//  ThemeSettings.swift
//  Task
//
//  Created by JWSScott777 on 10/31/20.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(themeSettings, forKey: "Theme")
        }
    }
}
