import Foundation
import AVFoundation
import MediaPlayer

class SingKJVManager: ObservableObject {
    @Published var currentBook: String?
    @Published var currentChapter: Int = 1
    @Published var isPlaying: Bool = false
    private var audioPlayer: AVPlayer?
    private var timeObserver: Any?
    
    init() {
        setupAudioSession()
        setupRemoteCommandCenter()
    }
    
    deinit {
        removeTimeObserver()
        teardownRemoteCommandCenter()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.resumePlaying()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pausePlaying()
            return .success
        }
        
        commandCenter.togglePlayPauseCommand.addTarget { [weak self] _ in
            if self?.isPlaying == true {
                self?.pausePlaying()
            } else {
                self?.resumePlaying()
            }
            return .success
        }
    }
    
    private func teardownRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.removeTarget(nil)
        commandCenter.pauseCommand.removeTarget(nil)
        commandCenter.togglePlayPauseCommand.removeTarget(nil)
    }
    
    func playSong(book: String, chapter: Int) {
        // Stop current playback if any
        stopPlaying()
        
        // Format the URL according to singthekjv.app structure
        let formattedBook = book.lowercased().replacingOccurrences(of: " ", with: "")
        let urlString = "https://singthekjv.app/\(formattedBook)\(chapter).song.mp3"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a new player item
        let playerItem = AVPlayerItem(url: url)
        
        // Create a new player
        audioPlayer = AVPlayer(playerItem: playerItem)
        
        // Add observer for when playback ends
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                             object: playerItem,
                                             queue: .main) { [weak self] _ in
            self?.isPlaying = false
        }
        
        // Add time observer to update UI
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] _ in
            self?.objectWillChange.send()
        }
        
        // Set up now playing info
        setupNowPlayingInfo(book: book, chapter: chapter)
        
        // Play the audio
        audioPlayer?.play()
        isPlaying = true
        currentChapter = chapter
        currentBook = book
    }
    
    func pausePlaying() {
        audioPlayer?.pause()
        isPlaying = false
    }
    
    func resumePlaying() {
        audioPlayer?.play()
        isPlaying = true
    }
    
    func stopPlaying() {
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
        currentChapter = 1
        currentBook = nil
        removeTimeObserver()
    }
    
    private func removeTimeObserver() {
        if let observer = timeObserver {
            audioPlayer?.removeTimeObserver(observer)
            timeObserver = nil
        }
    }
    
    private func setupNowPlayingInfo(book: String, chapter: Int) {
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "\(book) \(chapter)"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Sing The KJV"
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
} 