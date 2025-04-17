import SwiftUI

struct BibleView: View {
    var body: some View {
        VStack {
            Text("Bible Content")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // TODO: Add Bible content implementation
            Text("Bible content will be implemented here")
                .foregroundColor(.white)
                .padding()
        }
    }
}

#Preview {
    BibleView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 