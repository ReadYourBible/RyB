import SwiftUI

struct DailyVerseView: View {
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
                    // Share functionality will be added later
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