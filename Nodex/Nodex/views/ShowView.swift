//
//  ShowView.swift
//  NodexA30
//
//  Created by Alikadev on 12.06.23.
//

import SwiftUI
import MapKit

struct ShowView: View
{
	@ObservedObject var state = StateManager.shared
	@ObservedObject var ctrl: ShowCtrl
	
	init(node: Node)
	{
		ctrl = ShowCtrl(node: node)
	}
	
    var body: some View
	{
		VStack
		{
			Text(ctrl.node!.name)
				.font(.system(size: 25, weight: .semibold))
				.padding(.top)
				.padding(.bottom, 5)
			ScrollView(.vertical)
			{
				Text(ctrl.node?.content ?? "")
			}
			.frame(height: 100)
			Map(coordinateRegion: $ctrl.region,
				showsUserLocation: true,
				annotationItems: ctrl.getPlaces())
			{ node in
				MapAnnotation(coordinate: CLLocationCoordinate2D(
					latitude: node.lat!,
					longitude: node.lon!))
				{
					ZStack
					{
						Triangle()
							.rotation(.degrees(180))
							.foregroundColor(.accentColor)
							.frame(maxWidth: 15)
						Text(node.name)
							.font(.system(
								size: 12,
								weight: .semibold))
							.padding(5)
							.foregroundColor(.white)
							.background(Capsule()
								.foregroundColor(.accentColor))
							.offset(y: -20)
					}
				}
			}
			.ignoresSafeArea()
		}
    }
}

struct ShowView_Previews: PreviewProvider
{
    static var previews: some View
	{
		ShowView(node: Node("Personnal", content: "This is\na test",
							coord: CLLocation(latitude: 47.3, longitude: 8.5),
							childs: [
								Node("HI", coord: CLLocation(latitude: 47.305, longitude: 8.5)),
								Node("Hello", coord: CLLocation(latitude: 47.310, longitude: 8.5)),
								Node("Triste", coord: CLLocation(latitude: 47.315, longitude: 8.5))
							]))
    }
}
