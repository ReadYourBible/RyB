import SwiftUI

struct HymnalView: View {
    @State private var searchText = ""
    @Environment(\.colorScheme) var colorScheme
    
    // Sample hymn data - in a real app, this would come from a data source
    private let hymns = [
        "Amazing Grace",
        "How Great Thou Art",
        "Great Is Thy Faithfulness",
        "Blessed Assurance",
        "It Is Well With My Soul",
        "In Christ Alone",
        "Be Thou My Vision",
        "Holy, Holy, Holy",
        "The Old Rugged Cross",
        "What a Friend We Have in Jesus"
    ]
    
    var filteredHymns: [String] {
        if searchText.isEmpty {
            return hymns
        } else {
            return hymns.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hymnal")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.top)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                    TextField("Search hymns...", text: $searchText)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .autocapitalization(.none)
                }
                .padding()
                .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Hymn List
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(filteredHymns, id: \.self) { hymn in
                        HStack {
                            Text("\(hymns.firstIndex(of: hymn)! + 1).")
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Text(hymn)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    HymnalView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 