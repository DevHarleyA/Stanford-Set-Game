//
//  Set_GameApp.swift
//  Set-Game
//
//  Created by Alexandra Harley on 7/16/23.
//

import SwiftUI

@main
struct Set_GameApp: App {
    let game = SetViewModel()
    
    var body: some Scene {
        WindowGroup {
           SetGameView(game: game)
        }
    }
}
