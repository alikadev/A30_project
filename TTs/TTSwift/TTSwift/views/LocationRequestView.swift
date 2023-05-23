//
//  LocationRequestView.swift
//  Swift VS React
//
//  Created by Alikadev on 20.05.23.
//

import SwiftUI
import CoreLocation

struct LocationRequestView: View {
	var body: some View {
		ZStack
		{
			Color(.systemBlue).ignoresSafeArea()
			
			VStack
			{
				Image(systemName: "paperplane.circle.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 200)
					.padding(.bottom, 32)
				
				Text("Would you like to explace places nearby?")
					.font(.system(size: 28, weight: .semibold))
					.multilineTextAlignment(.center)
					.padding()
				
				Text("Start sharing your location with us")
					.multilineTextAlignment(.center)
					.frame(width: 140)
					.padding()
				
				Spacer()
				
				VStack
				{
					Spacer()
					Button
					{
						LocationManager.shared.requestLocation()
					} label: {
						HStack {
							Text("Allow location")
								.padding()
								.font(.headline)
								.foregroundColor(Color(.systemBlue))
						}
					}
					.frame(width: UIScreen.main.bounds.width)
					.padding(.horizontal, -32)
					.background(Color.white)
					.clipShape(Capsule())
					.padding()
					
					Button
					{
						LocationManager.shared.userLocation = CLLocation(
							latitude: LocationManager.shared.region.center.latitude,
							longitude: LocationManager.shared.region.center.longitude)
					} label: {
						Text("Maybe later")
							.padding()
							.font(.headline)
							.foregroundColor(.white)
					}
				}
				.padding(.bottom, 32)
			}
			.foregroundColor(.white)
		}
	}
}

struct LocationRequestView_Previews: PreviewProvider {
	static var previews: some View {
		LocationRequestView()
	}
}
