import SwiftUI

struct AboutView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Text("About")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.top)
            
            // App Logo
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.vertical)
            
            // App Information
            VStack(alignment: .leading, spacing: 15) {
                InfoRow(title: "App Version", value: "1.0.0")
                InfoRow(title: "Developer", value: "Victor Matos")
                InfoRow(title: "iOS Version", value: "iOS 15.0+")
                
                Divider()
                    .background(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                
                Text("Description")
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text("RyB is an all Bible(KJV) related app.")
                    .font(.body)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
        }
    }
}

#Preview {
    AboutView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 
