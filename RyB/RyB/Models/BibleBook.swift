import Foundation

struct BibleBook: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let bookNumber: String
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
    
    let books: [BibleBook] = [
        // Old Testament
        BibleBook(name: "Genesis", bookNumber: "01", chapters: 50, testament: .old),
        BibleBook(name: "Exodus", bookNumber: "02", chapters: 40, testament: .old),
        BibleBook(name: "Leviticus", bookNumber: "03", chapters: 27, testament: .old),
        BibleBook(name: "Numbers", bookNumber: "04", chapters: 36, testament: .old),
        BibleBook(name: "Deuteronomy", bookNumber: "05", chapters: 34, testament: .old),
        BibleBook(name: "Joshua", bookNumber: "06", chapters: 24, testament: .old),
        BibleBook(name: "Judges", bookNumber: "07", chapters: 21, testament: .old),
        BibleBook(name: "Ruth", bookNumber: "08", chapters: 4, testament: .old),
        BibleBook(name: "1 Samuel", bookNumber: "09", chapters: 31, testament: .old),
        BibleBook(name: "2 Samuel", bookNumber: "10", chapters: 24, testament: .old),
        BibleBook(name: "1 Kings", bookNumber: "11", chapters: 22, testament: .old),
        BibleBook(name: "2 Kings", bookNumber: "12", chapters: 25, testament: .old),
        BibleBook(name: "1 Chronicles", bookNumber: "13", chapters: 29, testament: .old),
        BibleBook(name: "2 Chronicles", bookNumber: "14", chapters: 36, testament: .old),
        BibleBook(name: "Ezra", bookNumber: "15", chapters: 10, testament: .old),
        BibleBook(name: "Nehemiah", bookNumber: "16", chapters: 13, testament: .old),
        BibleBook(name: "Esther", bookNumber: "17", chapters: 10, testament: .old),
        BibleBook(name: "Job", bookNumber: "18", chapters: 42, testament: .old),
        BibleBook(name: "Psalms", bookNumber: "19", chapters: 150, testament: .old),
        BibleBook(name: "Proverbs", bookNumber: "20", chapters: 31, testament: .old),
        BibleBook(name: "Ecclesiastes", bookNumber: "21", chapters: 12, testament: .old),
        BibleBook(name: "Song of Solomon", bookNumber: "22", chapters: 8, testament: .old),
        BibleBook(name: "Isaiah", bookNumber: "23", chapters: 66, testament: .old),
        BibleBook(name: "Jeremiah", bookNumber: "24", chapters: 52, testament: .old),
        BibleBook(name: "Lamentations", bookNumber: "25", chapters: 5, testament: .old),
        BibleBook(name: "Ezekiel", bookNumber: "26", chapters: 48, testament: .old),
        BibleBook(name: "Daniel", bookNumber: "27", chapters: 12, testament: .old),
        BibleBook(name: "Hosea", bookNumber: "28", chapters: 14, testament: .old),
        BibleBook(name: "Joel", bookNumber: "29", chapters: 3, testament: .old),
        BibleBook(name: "Amos", bookNumber: "30", chapters: 9, testament: .old),
        BibleBook(name: "Obadiah", bookNumber: "31", chapters: 1, testament: .old),
        BibleBook(name: "Jonah", bookNumber: "32", chapters: 4, testament: .old),
        BibleBook(name: "Micah", bookNumber: "33", chapters: 7, testament: .old),
        BibleBook(name: "Nahum", bookNumber: "34", chapters: 3, testament: .old),
        BibleBook(name: "Habakkuk", bookNumber: "35", chapters: 3, testament: .old),
        BibleBook(name: "Zephaniah", bookNumber: "36", chapters: 3, testament: .old),
        BibleBook(name: "Haggai", bookNumber: "37", chapters: 2, testament: .old),
        BibleBook(name: "Zechariah", bookNumber: "38", chapters: 14, testament: .old),
        BibleBook(name: "Malachi", bookNumber: "39", chapters: 4, testament: .old),
        
        // New Testament
        BibleBook(name: "Matthew", bookNumber: "40", chapters: 28, testament: .new),
        BibleBook(name: "Mark", bookNumber: "41", chapters: 16, testament: .new),
        BibleBook(name: "Luke", bookNumber: "42", chapters: 24, testament: .new),
        BibleBook(name: "John", bookNumber: "43", chapters: 21, testament: .new),
        BibleBook(name: "Acts", bookNumber: "44", chapters: 28, testament: .new),
        BibleBook(name: "Romans", bookNumber: "45", chapters: 16, testament: .new),
        BibleBook(name: "1 Corinthians", bookNumber: "46", chapters: 16, testament: .new),
        BibleBook(name: "2 Corinthians", bookNumber: "47", chapters: 13, testament: .new),
        BibleBook(name: "Galatians", bookNumber: "48", chapters: 6, testament: .new),
        BibleBook(name: "Ephesians", bookNumber: "49", chapters: 6, testament: .new),
        BibleBook(name: "Philippians", bookNumber: "50", chapters: 4, testament: .new),
        BibleBook(name: "Colossians", bookNumber: "51", chapters: 4, testament: .new),
        BibleBook(name: "1 Thessalonians", bookNumber: "52", chapters: 5, testament: .new),
        BibleBook(name: "2 Thessalonians", bookNumber: "53", chapters: 3, testament: .new),
        BibleBook(name: "1 Timothy", bookNumber: "54", chapters: 6, testament: .new),
        BibleBook(name: "2 Timothy", bookNumber: "55", chapters: 4, testament: .new),
        BibleBook(name: "Titus", bookNumber: "56", chapters: 3, testament: .new),
        BibleBook(name: "Philemon", bookNumber: "57", chapters: 1, testament: .new),
        BibleBook(name: "Hebrews", bookNumber: "58", chapters: 13, testament: .new),
        BibleBook(name: "James", bookNumber: "59", chapters: 5, testament: .new),
        BibleBook(name: "1 Peter", bookNumber: "60", chapters: 5, testament: .new),
        BibleBook(name: "2 Peter", bookNumber: "61", chapters: 3, testament: .new),
        BibleBook(name: "1 John", bookNumber: "62", chapters: 5, testament: .new),
        BibleBook(name: "2 John", bookNumber: "63", chapters: 1, testament: .new),
        BibleBook(name: "3 John", bookNumber: "64", chapters: 1, testament: .new),
        BibleBook(name: "Jude", bookNumber: "65", chapters: 1, testament: .new),
        BibleBook(name: "Revelation", bookNumber: "66", chapters: 22, testament: .new)
    ]
} 
