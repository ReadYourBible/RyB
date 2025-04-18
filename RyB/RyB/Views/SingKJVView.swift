import SwiftUI

struct SingKJVView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var singKJVManager: SingKJVManager
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
            
            // Playback Controls
            if singKJVManager.isPlaying || singKJVManager.currentBook != nil {
                VStack(spacing: 5) {
                    // Progress Bar
                    VStack(spacing: 2) {
                        Slider(value: Binding(
                            get: { singKJVManager.currentTime },
                            set: { newValue in
                                singKJVManager.seek(to: newValue)
                            }
                        ), in: 0...singKJVManager.duration)
                        .accentColor(.blue)
                        
                        HStack {
                            Text(formatTime(singKJVManager.currentTime))
                                .font(.caption)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                            Spacer()
                            Text(formatTime(singKJVManager.duration))
                                .font(.caption)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                        }
                    }
                    .padding(.horizontal)
                    
                    // Control Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            singKJVManager.stopPlaying()
                        }) {
                            Image(systemName: "stop.fill")
                                .font(.title3)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        
                        Button(action: {
                            if singKJVManager.isPlaying {
                                singKJVManager.pausePlaying()
                            } else {
                                singKJVManager.resumePlaying()
                            }
                        }) {
                            Image(systemName: singKJVManager.isPlaying ? "pause.fill" : "play.fill")
                                .font(.title2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    
                    if let book = singKJVManager.currentBook {
                        Text("\(book) \(singKJVManager.currentChapter)")
                            .font(.subheadline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                .padding(.vertical, 8)
                .background(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
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
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
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
    SingKJVView(singKJVManager: SingKJVManager())
        .background(Color(red: 0.1, green: 0.2, blue: 0.3))
} 