import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct DailyVerseView: View {
    @State private var showingShareSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Daily Verse")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                // TODO: Dynamic daily Bible verse
                Text("John 3:16")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                
                Text("For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: {
                    showingShareSheet = true
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
                }
                .sheet(isPresented: $showingShareSheet) {
                    ShareSheet(activityItems: ["John 3:16 - For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."])
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DailyVerseView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 