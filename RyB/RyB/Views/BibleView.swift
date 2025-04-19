import SwiftUI

struct BibleView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var bibleManager = BibleManager()
    @State private var selectedTestament: BibleBook.Testament = .old
    @State private var searchText = ""
    @State private var selectedChapter: Int = 1
    @State private var chapterContent: String = ""
    
    var filteredBooks: [BibleBook] {
        let testamentFiltered = bibleManager.books.filter { $0.testament == selectedTestament }
        if searchText.isEmpty {
            return testamentFiltered
        } else {
            return testamentFiltered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            if let currentBook = bibleManager.currentBook {
                // Book View
                VStack(spacing: 0) {
                    // Book Navigation
                    HStack(spacing: 0) {
                        Button(action: {
                            if let previousBook = getPreviousBook() {
                                bibleManager.currentBook = previousBook
                                selectedChapter = 1
                                loadChapterContent()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(getPreviousBook() == nil)
                        
                        // Fixed width container for book name
                        Text(currentBook.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 240, height: 44)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Button(action: {
                            if let nextBook = getNextBook() {
                                bibleManager.currentBook = nextBook
                                selectedChapter = 1
                                loadChapterContent()
                            }
                        }) {
                            Image(systemName: "arrow.right")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(getNextBook() == nil)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    
                    // Chapter Navigation
                    HStack(spacing: 0) {
                        Button(action: {
                            if selectedChapter > 1 {
                                selectedChapter -= 1
                                loadChapterContent()
                            }
                        }) {
                            Text("<")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(selectedChapter <= 1)
                        
                        Text("Chapter \(selectedChapter)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 160, height: 44)
                        
                        Button(action: {
                            if selectedChapter < currentBook.chapters {
                                selectedChapter += 1
                                loadChapterContent()
                            }
                        }) {
                            Text(">")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                        }
                        .disabled(selectedChapter >= currentBook.chapters)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.6))
                    
                    // Chapter Content
                    ScrollView {
                        Text(chapterContent)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    // Return Button
                    Button(action: {
                        bibleManager.currentBook = nil
                        selectedChapter = 1
                        chapterContent = ""
                    }) {
                        HStack {
                            Image(systemName: "arrow.uturn.left")
                            Text("Return to Books")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                    }
                    .padding()
                }
                .onAppear {
                    loadChapterContent()
                }
            } else {
                // Books List View
                VStack {
                    // Testament Picker
                    Picker("Testament", selection: $selectedTestament) {
                        Text("Old Testament").tag(BibleBook.Testament.old)
                        Text("New Testament").tag(BibleBook.Testament.new)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
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
                        VStack(spacing: 10) {
                            ForEach(filteredBooks) { book in
                                Button(action: {
                                    bibleManager.currentBook = book
                                    selectedChapter = 1
                                }) {
                                    Text(book.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.black.opacity(0.8))
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .background(Color.black)
    }
    
    private func loadChapterContent() {
        guard let currentBook = bibleManager.currentBook else { return }
        
        // Format the book name for the file path
        let bookName = currentBook.name.lowercased().replacingOccurrences(of: " ", with: "-")
        let chapterPath = "Resources/kjv/\(bookName)/\(bookName)-\(selectedChapter).txt"
        
        do {
            if let content = try? String(contentsOfFile: chapterPath, encoding: .utf8) {
                chapterContent = content
            } else {
                chapterContent = "Error loading chapter content"
            }
        }
    }
    
    private func getPreviousBook() -> BibleBook? {
        guard let currentBook = bibleManager.currentBook,
              let currentIndex = bibleManager.books.firstIndex(of: currentBook),
              currentIndex > 0 else {
            return nil
        }
        return bibleManager.books[currentIndex - 1]
    }
    
    private func getNextBook() -> BibleBook? {
        guard let currentBook = bibleManager.currentBook,
              let currentIndex = bibleManager.books.firstIndex(of: currentBook),
              currentIndex < bibleManager.books.count - 1 else {
            return nil
        }
        return bibleManager.books[currentIndex + 1]
    }
}

#Preview {
    BibleView()
} 