import Foundation

struct Verse {
    let reference: String
    let text: String
}

class DailyVerseManager: ObservableObject {
    @Published var currentVerse: Verse?
    private var allVerses: [Verse] = []
    private var lastLoadedDate: Date?
    
    init() {
        loadDailyVerse()
    }
    
    @objc private func appDidBecomeActive() {
        // Check if we need to update the verse for a new day
        if let lastDate = lastLoadedDate {
            let calendar = Calendar.current
            if !calendar.isDate(lastDate, inSameDayAs: Date()) {
                loadDailyVerse()
            }
        }
    }
    
    public func loadDailyVerse() {
        // Check if we need to load verses
        if allVerses.isEmpty {
            loadAllVerses()
        }
        
        // Get today's date components
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: today)
        
        // Use the date components to generate a consistent seed for the day
        let seed = (components.year ?? 0) * 10000 + (components.month ?? 0) * 100 + (components.day ?? 0)
        
        // Select a verse based on the seed
        if !allVerses.isEmpty {
            let index = abs(seed) % allVerses.count
            currentVerse = allVerses[index]
        } else {
            // If no verses were loaded, set a default verse
            currentVerse = Verse(reference: "John 3:16", text: "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.")
        }
    }
    
    private func loadAllVerses() {
        // Load verses only from Psalms, Ecclesiastes, and Proverbs
        let allowedBooks = ["Psalms", "Ecclesiastes", "Proverbs"]
        
        for book in BibleManager().books {
            // Only process allowed books
            guard allowedBooks.contains(book.name) else { continue }
            
            for chapter in 1...book.chapters {
                let bookName = book.name.lowercased()
                let chapterNumber = String(format: "%02d", chapter)
                let fileName = "\(bookName)-\(chapterNumber)"
                
                if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
                    do {
                        let content = try String(contentsOfFile: path, encoding: .utf8)
                        let lines = content.components(separatedBy: .newlines)
                        
                        // Create verses from the lines
                        for (index, line) in lines.enumerated() {
                            if !line.isEmpty {
                                let reference = "\(book.name) \(chapter):\(index + 1)"
                                let verse = Verse(reference: reference, text: line)
                                allVerses.append(verse)
                            }
                        }
                    } catch {
                        print("Error loading chapter \(chapter) of \(book.name): \(error)")
                    }
                }
            }
        }
        
        print("Successfully loaded \(allVerses.count) verses from Psalms, Ecclesiastes, and Proverbs")
    }
}
