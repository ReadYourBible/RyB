import SwiftUI

struct PreachingView: View {
    var body: some View {
        VStack {
            Text("Preaching Content")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // TODO: Add preaching content implementation
            Text("Preaching content will be implemented here")
                .foregroundColor(.white)
                .padding()
        }
    }
}

#Preview {
    PreachingView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 