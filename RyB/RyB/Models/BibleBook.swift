import Foundation

struct BibleBook: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let chapters: Int
    let testament: Testament
    
    enum Testament: String {
        case old = "Old Testament"
        case new = "New Testament"
    }
    
    static func == (lhs: BibleBook, rhs: BibleBook) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class BibleManager: ObservableObject {
    @Published var currentBook: BibleBook?
    @Published var currentChapter: Int = 1
    
    let books: [BibleBook] = [
        // Old Testament
        BibleBook(name: "Genesis", chapters: 50, testament: .old),
        BibleBook(name: "Exodus", chapters: 40, testament: .old),
        BibleBook(name: "Leviticus", chapters: 27, testament: .old),
        BibleBook(name: "Numbers", chapters: 36, testament: .old),
        BibleBook(name: "Deuteronomy", chapters: 34, testament: .old),
        BibleBook(name: "Joshua", chapters: 24, testament: .old),
        BibleBook(name: "Judges", chapters: 21, testament: .old),
        BibleBook(name: "Ruth", chapters: 4, testament: .old),
        BibleBook(name: "1 Samuel", chapters: 31, testament: .old),
        BibleBook(name: "2 Samuel", chapters: 24, testament: .old),
        BibleBook(name: "1 Kings", chapters: 22, testament: .old),
        BibleBook(name: "2 Kings", chapters: 25, testament: .old),
        BibleBook(name: "1 Chronicles", chapters: 29, testament: .old),
        BibleBook(name: "2 Chronicles", chapters: 36, testament: .old),
        BibleBook(name: "Ezra", chapters: 10, testament: .old),
        BibleBook(name: "Nehemiah", chapters: 13, testament: .old),
        BibleBook(name: "Esther", chapters: 10, testament: .old),
        BibleBook(name: "Job", chapters: 42, testament: .old),
        BibleBook(name: "Psalm", chapters: 150, testament: .old),
        BibleBook(name: "Proverbs", chapters: 31, testament: .old),
        BibleBook(name: "Ecclesiastes", chapters: 12, testament: .old),
        BibleBook(name: "Song of Solomon", chapters: 8, testament: .old),
        BibleBook(name: "Isaiah", chapters: 66, testament: .old),
        BibleBook(name: "Jeremiah", chapters: 52, testament: .old),
        BibleBook(name: "Lamentations", chapters: 5, testament: .old),
        BibleBook(name: "Ezekiel", chapters: 48, testament: .old),
        BibleBook(name: "Daniel", chapters: 12, testament: .old),
        BibleBook(name: "Hosea", chapters: 14, testament: .old),
        BibleBook(name: "Joel", chapters: 3, testament: .old),
        BibleBook(name: "Amos", chapters: 9, testament: .old),
        BibleBook(name: "Obadiah", chapters: 1, testament: .old),
        BibleBook(name: "Jonah", chapters: 4, testament: .old),
        BibleBook(name: "Micah", chapters: 7, testament: .old),
        BibleBook(name: "Nahum", chapters: 3, testament: .old),
        BibleBook(name: "Habakkuk", chapters: 3, testament: .old),
        BibleBook(name: "Zephaniah", chapters: 3, testament: .old),
        BibleBook(name: "Haggai", chapters: 2, testament: .old),
        BibleBook(name: "Zechariah", chapters: 14, testament: .old),
        BibleBook(name: "Malachi", chapters: 4, testament: .old),
        
        // New Testament
        BibleBook(name: "Matthew", chapters: 28, testament: .new),
        BibleBook(name: "Mark", chapters: 16, testament: .new),
        BibleBook(name: "Luke", chapters: 24, testament: .new),
        BibleBook(name: "John", chapters: 21, testament: .new),
        BibleBook(name: "Acts", chapters: 28, testament: .new),
        BibleBook(name: "Romans", chapters: 16, testament: .new),
        BibleBook(name: "1 Corinthians", chapters: 16, testament: .new),
        BibleBook(name: "2 Corinthians", chapters: 13, testament: .new),
        BibleBook(name: "Galatians", chapters: 6, testament: .new),
        BibleBook(name: "Ephesians", chapters: 6, testament: .new),
        BibleBook(name: "Philippians", chapters: 4, testament: .new),
        BibleBook(name: "Colossians", chapters: 4, testament: .new),
        BibleBook(name: "1 Thessalonians", chapters: 5, testament: .new),
        BibleBook(name: "2 Thessalonians", chapters: 3, testament: .new),
        BibleBook(name: "1 Timothy", chapters: 6, testament: .new),
        BibleBook(name: "2 Timothy", chapters: 4, testament: .new),
        BibleBook(name: "Titus", chapters: 3, testament: .new),
        BibleBook(name: "Philemon", chapters: 1, testament: .new),
        BibleBook(name: "Hebrews", chapters: 13, testament: .new),
        BibleBook(name: "James", chapters: 5, testament: .new),
        BibleBook(name: "1 Peter", chapters: 5, testament: .new),
        BibleBook(name: "2 Peter", chapters: 3, testament: .new),
        BibleBook(name: "1 John", chapters: 5, testament: .new),
        BibleBook(name: "2 John", chapters: 1, testament: .new),
        BibleBook(name: "3 John", chapters: 1, testament: .new),
        BibleBook(name: "Jude", chapters: 1, testament: .new),
        BibleBook(name: "Revelation", chapters: 22, testament: .new)
    ]
    
    func getPreviousBook() -> BibleBook? {
        guard let currentBook = currentBook,
              let currentIndex = books.firstIndex(of: currentBook),
              currentIndex > 0 else {
            return nil
        }
        return books[currentIndex - 1]
    }
    
    func getNextBook() -> BibleBook? {
        guard let currentBook = currentBook,
              let currentIndex = books.firstIndex(of: currentBook),
              currentIndex < books.count - 1 else {
            return nil
        }
        return books[currentIndex + 1]
    }
} 
