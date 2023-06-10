//
//  NodeView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import SwiftUI

struct NodeView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var state = StateManager.shared
	var ctrl: NodeCtrl
	@State var createChildNode = false
	@State var editNode = false
	@State var showNode = false
	
	init(_ node: Node, parent: Node, path: String)
	{
		ctrl = NodeCtrl(node, parent: parent, path: path)
	}
	
    var body: some View {
		NavigationView
		{
			ZStack
			{
				ScrollView
				{
					VStack
					{
						ForEach(ctrl.node.childs)
						{ child in
							NavigationLink
							{
								NodeView(child, parent: ctrl.node, path: ctrl.path+"/"+ctrl.node.name)
							} label: {
								HStack
								{
									Text(child.name)
									Spacer()
									Text(Image(systemName: "chevron.right"))
								}
							}
							.padding()
							.background(Capsule()
								.foregroundColor(Color(.secondarySystemBackground))
								.shadow(radius: 2))
							
						}
						Spacer()
					}
					.padding()
				}
				HStack
				{
					Spacer()
					VStack
					{
						Spacer()
						Button
						{
							showNode.toggle()
						} label: {
							Image(systemName: "eye")
								.padding()
								.background(Capsule()
									.foregroundColor(Color(.secondarySystemBackground))
									.shadow(radius: 5))
						}
					}
					.padding()
				}
			}
			.sheet(isPresented: $createChildNode)
			{
				EditView(parent: ctrl.node)
			}
			.sheet(isPresented: $editNode)
			{
				EditView(node: ctrl.node)
			}
			.sheet(isPresented: $showNode)
			{
				EmptyView()
			}
			.toolbar
			{
				ToolbarItem(placement: .principal)
				{
					VStack
					{
						Text(ctrl.node.name)
							.font(.system(size: 20, weight: .semibold))
						Text(ctrl.path + "/" + ctrl.node.name)
							.font(.system(size: 12, weight: .regular))
					}
				}
				ToolbarItem(placement: .confirmationAction)
				{
					Menu
					{
						Button
						{
							createChildNode.toggle()
						} label: {
							HStack
							{
								Text("Add Node")
								Spacer()
								Image(systemName: "plus")
									.padding()
									.background(Capsule()
										.foregroundColor(Color(.secondarySystemBackground))
										.shadow(radius: 5))
							}
						}
						Button
						{
							showNode.toggle()
						} label: {
							HStack
							{
								Text("Show Node")
								Spacer()
								Image(systemName: "eye")
									.padding()
									.background(Capsule()
										.foregroundColor(Color(.secondarySystemBackground))
										.shadow(radius: 5))
							}
						}
						Button
						{
							ctrl.removeNode()
							state.objectWillChange.send()
							presentationMode.wrappedValue.dismiss()
						} label: {
							HStack
							{
								Text("Remove Node")
								Spacer()
								Image(systemName: "trash")
							}
						}
						Button
						{
							print("BEFORE",ctrl.node.name)
							editNode.toggle()
						} label: {
							HStack
							{
								Text("Edit Node")
								Spacer()
								Image(systemName: "pencil")
							}
						}
					} label: {
						Image(systemName: "ellipsis")
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
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
		NodeView(
			Node("Example",
				 content: "Hey, this is a test!\nBe cool",
				 childs: [
					Node("Example1"),
					Node("Example2")
				 ]),
			parent: Node(""),
			path: "")
	}
}
