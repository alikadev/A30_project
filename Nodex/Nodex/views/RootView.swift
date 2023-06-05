//
//  RootView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import SwiftUI

struct RootView: View {
	@State var ctrl = RootCtrl()
	
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
								EmptyView()
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
					Text("Hi")
						.font(.system(size: 20, weight: .semibold))
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
