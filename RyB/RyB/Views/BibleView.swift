import SwiftUI

struct BibleView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Bible Content")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            // TODO: Add Bible content implementation
            Text("Bible content will be implemented here")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
        }
    }
}

#Preview {
    BibleView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 