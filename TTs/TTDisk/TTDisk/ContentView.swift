//
//  ContentView.swift
//  TTDisk
//
//  Created by Alikadev on 22.05.23.
//

import SwiftUI

let KEY = "DATA"

struct ContentView: View {
	@State var data = PersonnalData(name: "", comment: "")
	let disk = DiskManager()
	
    var body: some View {
        VStack {
			/*
			 les champs de texte
			 */
			VStack
			{
				TextField("Name", text: $data.name)
				TextField("Comment", text: $data.comment)
			}
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.padding()
			.padding(.bottom, 40)
			
			/*
			 Les boutons
			 */
			HStack
			{
				// Sauvegarder dans le disque
				Button {
					if disk.save(data, key: KEY) == false
					{
						print("Fail to save data at \(KEY)")
					}
				} label: {
					Text("Save")
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
				}
				.padding()
				.foregroundColor(.white)
				.background(Rectangle()
					.foregroundColor(Color(.systemBlue))
					.cornerRadius(10))
				
				// Charger depuis le disque
				Button {
					let (state, data) = disk.load(type: PersonnalData.self, key: KEY)
					if state {
						self.data = data as! PersonnalData
					}
				} label: {
					Text("Load")
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
				}
				.padding()
				.foregroundColor(.white)
				.background(Rectangle()
					.foregroundColor(Color(.systemBlue))
					.cornerRadius(10))
			}
        }
        .padding()
		.onAppear() {
			/*
			 S'execute quand la page se load.
			 Permet de ne pas avoir à appuyer sur `Load`
			 */
			let (state, data) = disk.load(
				type: PersonnalData.self,
				key: KEY)
			if state
			{
				self.data = data as! PersonnalData
			}
		}
		.onDisappear() {
			/*
			 S'execute uniquement quand la view se retire. Utile si cette application serai multi-view
			 */
			if disk.save(data, key: KEY) == false
			{
				print("Fail to save data at \(KEY)")
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
