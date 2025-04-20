import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ShareVerseView: View {
    @StateObject private var verseManager = ShareVerseManager()
    @State private var showingShareSheet = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Share a Verse")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            VStack(spacing: 15) {
                if let verse = verseManager.currentVerse {
                    Text(verse.reference)
                        .font(.headline)
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.8))
                    
                    Text(verse.text)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding()
                        .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                        .cornerRadius(10)
                        .onTapGesture {
                            verseManager.loadNewVerse()
                        }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            verseManager.loadNewVerse()
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("New Verse")
                            }
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(8)
                        }
                        
                        Button(action: {
                            showingShareSheet = true
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(8)
                        }
                    }
                    .sheet(isPresented: $showingShareSheet) {
                        ShareSheet(activityItems: ["\(verse.reference)\n\n\(verse.text)"])
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .onAppear {
            verseManager.loadNewVerse()
        }
    }
}

#Preview {
    ShareVerseView()
        .preferredColorScheme(.dark)
} 