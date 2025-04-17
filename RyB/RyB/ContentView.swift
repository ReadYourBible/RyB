//
//  ContentView.swift
//  RyB
//
//  Created by VICTOR MATOS on 17/04/25.
//

import SwiftUI

struct DailyVerseView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Daily Verse")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                // TODO: Dynamic daily Bible verse
                Text("John 3:16")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                
                Text("For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: {
                    // Share functionality will be added later
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

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
                        // Home Tab
                        VStack(spacing: 30) {
                            Image("AppLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                            
                            Text("Many languages, but only one way to heaven.")
                                .font(.title2)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        .tag(0)
                        
                        // Bible Tab
                        Text("Bible Content")
                            .foregroundColor(.white)
                            .tag(1)
                        
                        // Daily Verse Tab
                        DailyVerseView()
                            .tag(2)
                        
                        // Preaching Tab
                        Text("Preaching Content")
                            .foregroundColor(.white)
                            .tag(3)
                    }
                    
                    // Bottom Navigation Bar
                    HStack {
                        Spacer()
                        
                        // Home Button
                        Button(action: { selectedTab = 0 }) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.title2)
                                Text("Home")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == 0 ? .white : .gray)
                        }
                        
                        Spacer()
                        
                        // Bible Button
                        Button(action: { selectedTab = 1 }) {
                            VStack {
                                Image(systemName: "book.fill")
                                    .font(.title2)
                                Text("Bible")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == 1 ? .white : .gray)
                        }
                        
                        Spacer()
                        
                        // Daily Verse Button
                        Button(action: { selectedTab = 2 }) {
                            VStack {
                                Image(systemName: "quote.bubble.fill")
                                    .font(.title2)
                                Text("Verse")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == 2 ? .white : .gray)
                        }
                        
                        Spacer()
                        
                        // Preaching Button
                        Button(action: { selectedTab = 3 }) {
                            VStack {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.title2)
                                Text("Preaching")
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == 3 ? .white : .gray)
                        }
                        
                        Spacer()
                    }
                    .padding()
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
                        // TODO: Navigate to Bible view
                    }
                    
                    MenuButton(title: "Preaching", icon: "speaker.wave.2.fill") {
                        // TODO: Navigate to Preaching view
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
