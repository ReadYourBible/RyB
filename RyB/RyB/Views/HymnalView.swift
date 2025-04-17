import SwiftUI

struct HymnalView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hymnal")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                
                // Sample Hymn List
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(1...10, id: \.self) { number in
                        HStack {
                            Text("\(number).")
                                .foregroundColor(.white)
                            Text("Amazing Grace")
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