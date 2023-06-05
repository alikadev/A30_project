//
//  NodeView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import SwiftUI

struct NodeView: View {
	@Environment(\.presentationMode) var presentationMode
	var ctrl: NodeCtrl
	@ObservedObject var state = State.shared
	
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
				VStack
				{
					Spacer()
					HStack
					{
						Spacer()
						NavigationLink
						{
							EmptyView()
						} label: {
							Image(systemName: "plus")
								.padding()
								.background(Capsule()
									.foregroundColor(Color(.secondarySystemBackground))
									.shadow(radius: 5))
						}
						.padding()
					}
				}
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
					Button
					{
						ctrl.removeNode()
						state.objectWillChange.send()
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "trash")
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
			Node("Example", childs: [
				Node("Example1"),
				Node("Example2")
			]),
			parent: Node(""),
			path: "")
	}
}
