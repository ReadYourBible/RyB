import SwiftUI

struct PreachingView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Preaching Content")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            // TODO: Add preaching content implementation
            Text("Preaching content will be implemented here")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
        }
    }
}

#Preview {
    PreachingView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 