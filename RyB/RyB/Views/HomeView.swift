import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 30) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .cornerRadius(20)
                .shadow(radius: 10)
            
            Text("Many languages, but only one way to heaven.")
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 