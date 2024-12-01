//
//  PreachingView.swift
//  RyB
//
//  Created by VICTOR deMATOS on 01/12/24.
//


import SwiftUI

struct PreachingView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var contentFile: URL?

    var body: some View {
        VStack {
            Text("Upload Preaching Content")
                .font(.title)
                .padding()

            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: selectFile) {
                Text("Select Content File")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let file = contentFile {
                Text("Selected file: \(file.lastPathComponent)")
                    .font(.footnote)
            }

            Button(action: uploadContent) {
                Text("Upload")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .padding()
    }

    func selectFile() {
        // File selection logic placeholder
        print("File selected")
    }

    func uploadContent() {
        // Upload logic placeholder
        print("Uploading content: \(title), \(description)")
    }
}
