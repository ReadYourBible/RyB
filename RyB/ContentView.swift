//
//  ContentView.swift
//  RyB
//
//  Created by VICTOR deMATOS on 01/12/24.
//

import SwiftUI

struct ContentView: View {
    // State variable to track the selected menu option
    @State private var selectedOption: String = "Home"

    // Menu options
    let menuOptions = ["Home", "Bible", "Preaching", "Reading"]

    var body: some View {
        VStack {
            // Dropdown menu
            Picker("Menu", selection: $selectedOption) {
                ForEach(menuOptions, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle()) // Makes it a dropdown menu
            .padding()

            // Display content based on selected option
            Spacer()
            if selectedOption == "Home" {
                Text("Welcome to the Home Page")
                    .font(.headline)
            } else if selectedOption == "Bible" {
                Text("Explore the Bible")
                    .font(.headline)
            } else if selectedOption == "Preaching" {
                Text("Preaching Resources")
                    .font(.headline)
            } else if selectedOption == "Reading" {
                Text("Start Reading Now")
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("RyB Menu")
    }
}

#Preview {
    ContentView()
}
