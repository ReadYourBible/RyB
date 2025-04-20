import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFeature: Feature?
    @StateObject private var singKJVManager = SingKJVManager()
    
    enum Feature: String, Identifiable {
        case singKJV = "Sing The KJV"
        case bibleWay = "Bible Way To Heaven"
        case about = "About"
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .singKJV: return "music.note"
            case .bibleWay: return "book.fill"
            case .about: return "info.circle"
            }
        }
        
        var description: String {
            switch self {
            case .singKJV: return "Listen to the Bible in song"
            case .bibleWay: return "Learn the path to salvation"
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
        case .bibleWay:
            BibleWayToHeavenView()
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

struct BibleWayToHeavenView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    SectionView(
                        title: "Acknowledgement",
                        subtitle: "Acknowledge Sin",
                        verse: "Romans 3:23",
                        content: "For all have sinned, and come short of the glory of God;"
                    )
                    
                    SectionView(
                        title: "Realization",
                        subtitle: "Realize the Penalty for Sin. Death & Hell",
                        verse: "Romans 6:23 | Revelation 21:8",
                        content: "For the wages of sin is death; but the gift of God is eternal life through Jesus Christ our Lord.\n\nBut the fearful, and unbelieving, and the abominable, and murderers, and whoremongers, and sorcerers, and idolaters, and all liars, shall have their part in the lake which burneth with fire and brimstone: which is the second death."
                    )
                    
                    SectionView(
                        title: "Admission",
                        subtitle: "Admit Sin",
                        verse: "1 John 1:8",
                        content: "If we say that we have no sin, we deceive ourselves, and the truth is not in us."
                    )
                    
                    SectionView(
                        title: "Understanding",
                        subtitle: "Understand Jesus Christ Died for You!",
                        verse: "John 3:16 | 1 Peter 2:24 | 1 Timothy 3:16",
                        content: "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.\n\nWho his own self bare our sins in his own body on the tree, that we, being dead to sins, should live unto righteousness: by whose stripes ye were healed.\n\nAnd without controversy great is the mystery of godliness: God was manifest in the flesh, justified in the Spirit, seen of angels, preached unto the Gentiles, believed on in the world, received up into glory."
                    )
                    
                    SectionView(
                        title: "Belief",
                        subtitle: "Believe for Salvation",
                        verse: "Romans 10:9-11",
                        content: "That if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved. For with the heart man believeth unto righteousness; and with the mouth confession is made unto salvation. For the scripture saith, Whosoever believeth on him shall not be ashamed."
                    )
                    
                    SectionView(
                        title: "Salvation",
                        subtitle: "Saved by Faith. Not of Works!",
                        verse: "Ephesians 2:8-9",
                        content: "For by grace are ye saved through faith; and that not of yourselves: it is the gift of God: Not of works, lest any man should boast."
                    )
                    
                    SectionView(
                        title: "Knowing",
                        subtitle: "How do I know I'm saved?",
                        verse: "1 John 5:10-13",
                        content: "He that believeth on the Son of God hath the witness in himself: he that believeth not God hath made him a liar; because he believeth not the record that God gave of his Son. And this is the record, that God hath given to us eternal life, and this life is in his Son. He that hath the Son hath life; and he that hath not the Son of God hath not life. These things have I written unto you that believe on the name of the Son of God; that ye may know that ye have eternal life, and that ye may believe on the name of the Son of God."
                    )
                    
                    SectionView(
                        title: "Praying",
                        subtitle: "What should I pray?",
                        verse: nil,
                        content: "There are no special words or prayer that will grant eternal life. We simply must confess Jesus and believe with all our heart. Below is a prayer based on the scriptures mentioned above.\n\nThe Sinner's Prayer"
                    )
                    
                    SectionView(
                        title: "Faith",
                        subtitle: "Salvation by Faith Alone",
                        verse: "Romans 4:5",
                        content: "But to him that worketh not, but believeth on him that justifieth the ungodly, his faith is counted for righteousness."
                    )
                    
                    SectionView(
                        title: "False Salvation",
                        subtitle: "What salvation is NOT!",
                        verse: nil,
                        content: "Salvation is NOT by believing or trusting in anything other than Jesus ALONE.\n\nSalvation is NOT:\n• Works or Good deeds\n• Faith plus Works\n• Faith plus Baptism\n• Faith plus \"Repenting of your sins\" or \"Turning from your sins\"\n• Faith plus \"Going to church\"\n• Faith plus \"Saying Hail Marys\"\n• Faith plus Anything else!\n\nSalvation is FAITH ALONE!"
                    )
                    
                    SectionView(
                        title: "Next Step",
                        subtitle: "Finding a Local Church",
                        verse: nil,
                        content: "Visit https://independentbaptist.church/ to find a local church."
                    )
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Bible Way To Heaven")
    }
}

struct SectionView: View {
    let title: String
    let subtitle: String
    let verse: String?
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(subtitle)
                .font(.headline)
            
            if let verse = verse {
                Text(verse)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Text(content)
                .font(.body)
                .padding(.top, 4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

#Preview {
    HomeView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
}
