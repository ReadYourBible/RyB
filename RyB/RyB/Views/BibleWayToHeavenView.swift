import SwiftUI

struct BibleWayToHeavenView: View {
    @Environment(\.colorScheme) var colorScheme
    
    enum Section: String, CaseIterable, Identifiable {
        case acknowledgement = "Acknowledgement"
        case realization = "Realization"
        case admission = "Admission"
        case understanding = "Understanding"
        case belief = "Belief"
        case salvation = "Salvation"
        case knowing = "Knowing"
        case praying = "Praying"
        case faith = "Faith"
        case falseSalvation = "False Salvation"
        case nextStep = "Next Step"
        
        var id: String { self.rawValue }
        
        var content: (title: String, description: String, verses: String) {
            switch self {
            case .acknowledgement:
                return ("Acknowledge Sin", "Acknowledge that you are a sinner.", "Romans 3:23")
            case .realization:
                return ("Realize the Penalty for Sin", "Death & Hell", "Romans 6:23 | Revelation 21:8")
            case .admission:
                return ("Admit Sin", "Admit that you are a sinner.", "1 John 1:8")
            case .understanding:
                return ("Understand Jesus Christ Died for You", "Jesus died for your sins", "John 3:16 | 1 Peter 2:24 | 1 Timothy 3:16")
            case .belief:
                return ("Believe for Salvation", "Believe in Jesus Christ for salvation", "Romans 10:9-11")
            case .salvation:
                return ("Saved by Faith", "Not of Works!", "Ephesians 2:8-9")
            case .knowing:
                return ("How do I know I'm saved?", "The assurance of salvation", "1 John 5:10-13")
            case .praying:
                return ("What should I pray?", "There are no special words or prayer that will grant eternal life. We simply must confess Jesus and believe with all our heart.", "")
            case .faith:
                return ("Salvation by Faith Alone", "Is Salvation really Faith Alone? YES! The Bible makes it abundantly clear that we are only saved by faith.", "")
            case .falseSalvation:
                return ("What salvation is NOT!", "Salvation is NOT by believing or trusting in anything other than Jesus ALONE.", "Romans 4:5")
            case .nextStep:
                return ("Finding a Local Church", "Find a local church to grow in your faith", "")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Bible Way To Heaven")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ForEach(Section.allCases) { section in
                    SectionCard(section: section, colorScheme: colorScheme)
                }
                
                Link("Find a Local Church", destination: URL(string: "https://militarygetsaved.tripod.com/findchurch.html")!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SectionCard: View {
    let section: BibleWayToHeavenView.Section
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(section.content.title)
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Text(section.content.description)
                .font(.body)
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.8))
            
            if !section.content.verses.isEmpty {
                Text(section.content.verses)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
        )
    }
}

#Preview {
    BibleWayToHeavenView()
} 
