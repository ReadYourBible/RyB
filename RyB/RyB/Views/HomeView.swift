import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFeature: Feature?
    @StateObject private var singKJVManager = SingKJVManager()
    
    enum Feature: String, Identifiable {
        case singKJV = "Sing The KJV"
        case about = "About"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .singKJV: return "music.note"
            case .about: return "info.circle"
            }
        }
        
        var description: String {
            switch self {
            case .singKJV: return "Listen to the Bible in song"
            case .about: return "Learn more about the app"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Logo and Motto
                    VStack(spacing: 20) {
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                        
                        Text("Many languages, but only one way to heaven.")
                            .font(.body)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.horizontal)
                            .dynamicTypeSize(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                    }
                    
                    // Feature Grid
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 15) {
                        ForEach(Feature.allCases) { feature in
                            NavigationLink(destination: destinationView(for: feature)) {
                                FeatureCard(feature: feature, colorScheme: colorScheme)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    private func destinationView(for feature: Feature) -> some View {
        switch feature {
        case .singKJV:
            SingKJVView(singKJVManager: singKJVManager)
        case .about:
            AboutView()
        }
    }
}

struct FeatureCard: View {
    let feature: HomeView.Feature
    let colorScheme: ColorScheme
    
    var body: some View {
        HStack {
            Image(systemName: feature.icon)
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.rawValue)
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text(feature.description)
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
        )
    }
}

extension HomeView.Feature: CaseIterable {}

#Preview {
    HomeView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
}
