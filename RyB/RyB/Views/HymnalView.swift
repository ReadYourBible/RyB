import SwiftUI

struct HymnalView: View {
    @State private var searchText = ""
    
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
                    .foregroundColor(.white)
                    .padding(.top)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.7))
                    TextField("Search hymns...", text: $searchText)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Hymn List
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(filteredHymns, id: \.self) { hymn in
                        HStack {
                            Text("\(hymns.firstIndex(of: hymn)! + 1).")
                                .foregroundColor(.white)
                            Text(hymn)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.1))
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