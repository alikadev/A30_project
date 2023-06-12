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
	@ObservedObject var ctrl: EditCtrl
	
	@State var name: String
	@State var content: String
	
	@State var popNameNotAlphaNum = false
	
	init(parent: Node)
	{
		ctrl = EditCtrl(parent: parent)
		_name = State(initialValue: "")
		_content = State(initialValue: "")
	}
	
	init(node: Node)
	{
		ctrl = EditCtrl(node: node)
		_name = State(initialValue: node.name)
		_content = State(initialValue: node.content ?? "")
		print("On init", "\""+node.name+"\"","\""+name+"\"")
	}
	
	var body: some View {
		VStack
		{
			Text(name.isEmpty ? "Node Name" : name)
				.font(.system(size: 20, weight: .semibold))
				.padding()
			HStack
			{
				Text("Name:")
				TextField("Node name", text: $name)
			}
			
			Map(coordinateRegion: $ctrl.region,
				annotationItems: ctrl.getPlaces())
			{ pos in
				MapMarker(coordinate: CLLocationCoordinate2D(
					latitude: pos.lat!,
					longitude: pos.lon!))
			}
			
			HStack
			{
				Text("Content:")
				Spacer()
			}
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
		EditView(parent: Node("OK"))
	}
}
