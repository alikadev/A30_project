//
//  RootView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import SwiftUI

struct RootView: View {
	var ctrl = RootCtrl()
	@ObservedObject var state = StateManager.shared
	
	@State var createNode = false
	@State var showNode = false
	
	var body: some View {
		NavigationView
		{
			ZStack
			{
				ScrollView
				{
					VStack
					{
						ForEach(ctrl.getRootNode().childs)
						{ child in
							NavigationLink
							{
								NodeView(child, parent: ctrl.getRootNode(), path: ctrl.getRootNode().name)
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
							createNode.toggle()
						} label: {
							Image(systemName: "plus")
								.padding()
								.background(Circle()
									.foregroundColor(Color(.secondarySystemBackground))
									.shadow(radius: 5))
						}
					}
					.padding()
				}
			}
			.sheet(isPresented: $createNode)
			{
				EditView(parent: ctrl.getRootNode())
			}
			.sheet(isPresented: $showNode)
			{
				ShowView(node: ctrl.getRootNode())
			}
			.toolbar
			{
				ToolbarItem(placement: .principal)
				{
					VStack
					{
						Text("Root")
							.font(.system(size: 20, weight: .semibold))
					}
				}
				ToolbarItem(placement: .confirmationAction)
				{
					Menu
					{
						Button
						{
							createNode.toggle()
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
					} label: {
						Image(systemName: "ellipsis")
					}
				}
			}
		}
		.onAppear()
		{
			ctrl.requestLocation()
			
			ctrl.loadNodes()
			state.objectWillChange.send()
		}
		.onDisappear()
		{
			ctrl.save()
		}
	}
}

struct RootView_Previews: PreviewProvider {
	static var previews: some View {
		RootView()
	}
}
