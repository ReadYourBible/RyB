import SwiftUI

struct BibleView: View {
    @Environment(\.colorScheme) var colorScheme
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
        VStack {
            if let currentBook = bibleManager.currentBook {
                // Book View
                VStack {
                    // Navigation Header
                    HStack {
                        Button(action: {
                            if let previousBook = bibleManager.getPreviousBook() {
                                bibleManager.currentBook = previousBook
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .disabled(bibleManager.getPreviousBook() == nil)
                        
                        Spacer()
                        
                        Text(currentBook.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            if let nextBook = bibleManager.getNextBook() {
                                bibleManager.currentBook = nextBook
                            }
                        }) {
                            Image(systemName: "arrow.right")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .disabled(bibleManager.getNextBook() == nil)
                    }
                    .padding()
                    .background(Color.black.opacity(0.8))
                    
                    // Return Button
                    Button(action: {
                        bibleManager.currentBook = nil
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
                    
                    Spacer()
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
}

#Preview {
    BibleView()
} 