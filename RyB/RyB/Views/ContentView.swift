//
//  ContentView.swift
//  RyB
//
//  Created by VICTOR MATOS on 17/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    @State private var showIntro = true
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Background color matching the app theme
            Color(red: 0.1, green: 0.2, blue: 0.3)
                .ignoresSafeArea()
            
            if showIntro {
                // Intro View with Animation
                VStack {
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        logoScale = 1.0
                        logoOpacity = 1.0
                    }
                    
                    // Automatically transition to main app after delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            showIntro = false
                        }
                    }
                }
            } else if !showMenu {
                // Main App View with Bottom Navigation
                VStack {
                    // Content Area
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .tag(0)
                        
                        BibleView()
                            .tag(1)
                        
                        DailyVerseView()
                            .tag(2)
                        
                        PreachingView()
                            .tag(3)
                            
                        HymnalView()
                            .tag(4)
                    }
                    
                    // Bottom Navigation Bar
                    HStack(spacing: 0) {
                        // Home Button
                        Button(action: { selectedTab = 0 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "house.fill")
                                    .font(.title2)
                                Text("Home")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedTab == 0 ? .white : .gray)
                        }
                        
                        // Bible Button
                        Button(action: { selectedTab = 1 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "book.fill")
                                    .font(.title2)
                                Text("Bible")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedTab == 1 ? .white : .gray)
                        }
                        
                        // Daily Verse Button
                        Button(action: { selectedTab = 2 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "quote.bubble.fill")
                                    .font(.title2)
                                Text("Verse")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedTab == 2 ? .white : .gray)
                        }
                        
                        // Message Button
                        Button(action: { selectedTab = 3 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.title2)
                                Text("Message")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedTab == 3 ? .white : .gray)
                        }
                        
                        // Hymnal Button
                        Button(action: { selectedTab = 4 }) {
                            VStack(spacing: 4) {
                                Image(systemName: "music.note.list")
                                    .font(.title2)
                                Text("Hymnal")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(selectedTab == 4 ? .white : .gray)
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color(red: 0.1, green: 0.2, blue: 0.3).opacity(0.8))
                }
            } else {
                // Menu View
                VStack(spacing: 20) {
                    Text("Choose Your Path")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    MenuButton(title: "Bible", icon: "book.fill") {
                        selectedTab = 1
                        showMenu = false
                    }
                    
                    MenuButton(title: "Message", icon: "speaker.wave.2.fill") {
                        selectedTab = 3
                        showMenu = false
                    }
                }
                .padding()
            }
        }
    }
}

struct MenuButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

#Preview {
    ContentView()
}
