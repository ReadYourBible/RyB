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
        // Get the path to the KJV directory in the app bundle
        guard let kjvPath = Bundle.main.path(forResource: "KJV", ofType: nil, inDirectory: nil) else {
            print("Could not find KJV directory in bundle")
            return
        }
        
        loadVersesFromPath(kjvPath)
    }
    
    private func loadVersesFromPath(_ path: String) {
        let fileManager = FileManager.default
        
        do {
            // Get all book directories
            let bookDirectories = try fileManager.contentsOfDirectory(atPath: path)
            
            for bookDir in bookDirectories {
                let bookPath = (path as NSString).appendingPathComponent(bookDir)
                
                // Get all chapter files in the book directory
                let chapterFiles = try fileManager.contentsOfDirectory(atPath: bookPath)
                
                for chapterFile in chapterFiles {
                    let chapterPath = (bookPath as NSString).appendingPathComponent(chapterFile)
                    
                    // Read the chapter file
                    if let content = try? String(contentsOfFile: chapterPath, encoding: .utf8) {
                        let lines = content.components(separatedBy: .newlines)
                        
                        // Create verses from the lines
                        for (index, line) in lines.enumerated() {
                            if !line.isEmpty {
                                let bookName = bookDir.components(separatedBy: "-").last ?? ""
                                let chapterNumber = chapterFile.components(separatedBy: "-").last?.components(separatedBy: ".").first ?? ""
                                let reference = "\(bookName.capitalized) \(chapterNumber):\(index + 1)"
                                
                                let verse = Verse(reference: reference, text: line)
                                allVerses.append(verse)
                            }
                        }
                    }
                }
            }
            
            print("Successfully loaded \(allVerses.count) verses from path: \(path)")
        } catch {
            print("Error loading verses: \(error.localizedDescription)")
        }
    }
}
