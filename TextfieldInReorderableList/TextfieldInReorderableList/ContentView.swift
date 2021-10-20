//
//  ContentView.swift
//  TextfieldInReorderableList
//
//  Created by Oliver Drobnik on 20.10.21.
//

import SwiftUI

// have an item that is identifiable so that it can be used with ForEach
struct Item: Identifiable
{
	let id = UUID()
	var title: String
}

struct ContentView: View
{
	// the base array for our list
	@State private var items = [Item(title: "One"),
								Item(title: "Two"),
								Item(title: "Three")]
	
	@State private var dismissKeyboardOnMove = false
	
	var body: some View {
		List {
			Section(header: Text("Steps to Reproduce"))
			{
				HStack(alignment: .top) {
					Text("**1.**")
					Text("Tap on the item titled 'One' below and modify the string.")
				}
				
				HStack(alignment: .top) {
					Text("**2.**")
					Text("Use the item's reorder handle to move it into second position.")
				}
				
				HStack(alignment: .top) {
					Text("**3.**")
					Text("Drag it back up into first position.")
				}
			}
			
			Section {
				ForEach(items) { item in
					
					// construct a custom binding
					let binding = Binding {
						item.title
					} set: { newTitle in
						// update item in items array instead of local let copy
						let index = items.firstIndex { $0.id == item.id }!
						items[index].title = newTitle
					}
					
					TextField("Text", text: binding)
				}
				.onMove { indexes, target in
					
					// need to dismiss the keyboard or else the bug occurs
					if dismissKeyboardOnMove
					{
						UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
					}
					
					items.move(fromOffsets: indexes, toOffset: target)
				}
				.onDelete { indexes in
					items.remove(atOffsets: indexes)
				}
			}
			
			
			
			Section(header: Text("Result"))
			{
				Text("**Expected:** That you can move the row back into first position.")
				Text("**Actual:** The system won't let you drop the row in first position.")
			}
			
			Section(header: Text("Workaround"), footer: Text("If the keyboard is dismissed before modifying the state var then the bug doesn't occur."))
			{
				Toggle("Dismiss keyboard on move", isOn: $dismissKeyboardOnMove)
			}
		}
		.navigationTitle("Demo")
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ContentView()
				.environment(\.editMode, .constant(EditMode.active))
		}
	}
}
