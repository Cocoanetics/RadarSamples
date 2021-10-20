//
//  TextfieldInReorderableListApp.swift
//  TextfieldInReorderableList
//
//  Created by Oliver Drobnik on 20.10.21.
//

import SwiftUI

@main
struct TextfieldInReorderableListApp: App {
    var body: some Scene {
        WindowGroup {
			NavigationView {
				ContentView()
					.environment(\.editMode, .constant(EditMode.active))
			}
        }
    }
}
