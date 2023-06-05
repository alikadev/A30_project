//
//  RootView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import SwiftUI

struct RootView: View {
	var ctrl = RootCtrl()
	@ObservedObject var state = State.shared
	
	func btnCreateNode() {
		
	}
	
	func onLoad() {
		ctrl.loadNodes()
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
						Text("Root")
							.font(.system(size: 20, weight: .semibold))
							
					}
					
				}
				ToolbarItem(placement: .confirmationAction)
				{
					Button
					{
						ctrl.reset()
						state.objectWillChange.send()
						ctrl.objectWillChange.send()
					} label: {
						Image(systemName: "exclamationmark.triangle")
							.foregroundColor(.yellow)
					}
				}
			}
		}
		.onAppear()
		{
			onLoad()
		}
	}
}

struct RootView_Previews: PreviewProvider {
	static var previews: some View {
		RootView()
	}
}
