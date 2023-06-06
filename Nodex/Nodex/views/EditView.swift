//
//  EditView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import SwiftUI
import MapKit

struct EditView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var state = StateManager.shared
	var ctrl: EditCtrl
	
	@State var name = String()
	@State var content = String()
	
	@State var popNameNotAlphaNum = false
	
	init(_ parent: Node)
	{
		ctrl = EditCtrl(parent)
	}
	
    var body: some View {
		NavigationView
		{
			VStack
			{
				HStack
				{
					Text("Name")
					TextField("Node name", text: $name)
				}
				Text("Content")
				TextEditor(text: $content)
					.shadow(radius: 1)
				HStack
				{
					Button
					{
						if !name.isAlphanumeric
						{
							popNameNotAlphaNum.toggle()
							return
						}
						
						ctrl.createNode(name, content: content)
						state.objectWillChange.send()
						presentationMode.wrappedValue.dismiss()
					} label: {
						Text("Save")
							.bold()
							.padding()
							.foregroundColor(.white)
							.background(Capsule()
								.foregroundColor(Color(.systemBlue)))
					}
					Spacer()
				}
			}
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.padding()
			.toolbar
			{
				ToolbarItem(placement: .principal)
				{
					VStack
					{
						Text(name.isEmpty ? "Node Name" : name)
							.font(.system(size: 20, weight: .semibold))
						//Text(ctrl.path + "/" + ctrl.node.name)
						//	.font(.system(size: 12, weight: .regular))
					}
				}
				ToolbarItem(placement: .navigation)
				{
					Button
					{
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "chevron.backward")
					}
				}
			}
		}
		.navigationBarBackButtonHidden(true)
		.alert(
			"Bad name for Node",
			isPresented: $popNameNotAlphaNum,
			actions: {
				Button("Ok") {popNameNotAlphaNum = false}
			},
			message: {
				Text("Node name only support alphanumeric")
			}
		)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
		EditView(Node("OK"))
    }
}
