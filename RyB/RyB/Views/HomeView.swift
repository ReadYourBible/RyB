import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFeature: Feature?
    
    enum Feature: String, Identifiable {
        case singKJV = "Sing The KJV"
        case bible = "Bible"
        case dailyVerse = "Daily Verse"
        case preaching = "Message"
        case hymnal = "Hymnal"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .singKJV: return "music.note"
            case .bible: return "book.fill"
            case .dailyVerse: return "quote.bubble.fill"
            case .preaching: return "speaker.wave.2.fill"
            case .hymnal: return "music.note.list"
            }
        }
        
        var description: String {
            switch self {
            case .singKJV: return "Listen to the Bible in song"
            case .bible: return "Read the King James Bible"
            case .dailyVerse: return "Get inspired daily"
            case .preaching: return "Listen to messages"
            case .hymnal: return "Browse hymns"
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
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.horizontal)
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
            SingKJVView()
        case .bible:
            BibleView()
        case .dailyVerse:
            DailyVerseView()
        case .preaching:
            PreachingView()
        case .hymnal:
            HymnalView()
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