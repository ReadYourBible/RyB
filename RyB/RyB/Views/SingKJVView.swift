import SwiftUI

struct SingKJVView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var singKJVManager = SingKJVManager()
    @StateObject private var bibleManager = BibleManager()
    @State private var selectedTestament: BibleBook.Testament = .old
    @State private var searchText = ""
    
    var filteredBooks: [BibleBook] {
        let testamentFiltered = bibleManager.books.filter { $0.testament == selectedTestament }
        if searchText.isEmpty {
            return testamentFiltered
        } else {
            return testamentFiltered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sing The KJV")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.top)
            
            // Testament Picker
            Picker("Testament", selection: $selectedTestament) {
                Text("Old Testament").tag(BibleBook.Testament.old)
                Text("New Testament").tag(BibleBook.Testament.new)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                TextField("Search books...", text: $searchText)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .autocapitalization(.none)
            }
            .padding()
            .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // Books List
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(filteredBooks) { book in
                        NavigationLink(destination: ChapterListView(book: book, singKJVManager: singKJVManager)) {
                            HStack {
                                Text(book.name)
                                    .font(.headline)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                            }
                            .padding()
                            .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

struct ChapterListView: View {
    let book: BibleBook
    @ObservedObject var singKJVManager: SingKJVManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Text(book.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(1...book.chapters, id: \.self) { chapter in
                        Button(action: {
                            if singKJVManager.isPlaying && singKJVManager.currentChapter == chapter && singKJVManager.currentBook == book.name {
                                singKJVManager.pausePlaying()
                            } else {
                                singKJVManager.playSong(book: book.name, chapter: chapter)
                            }
                        }) {
                            HStack {
                                Text("Chapter \(chapter)")
                                    .font(.headline)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                Spacer()
                                Image(systemName: singKJVManager.isPlaying && singKJVManager.currentChapter == chapter && singKJVManager.currentBook == book.name ? "pause.fill" : "play.fill")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(singKJVManager.isPlaying && singKJVManager.currentChapter == chapter && singKJVManager.currentBook == book.name ?
                                          Color.blue.opacity(0.2) :
                                            (colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1)))
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    SingKJVView()
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 