//
//  SwiftUIView.swift
//  animation
//
//  Created by Kapil Soni on 2024-02-19.
//

import SwiftUI

struct CustomCaller: View {
    
    // State variable to track the call status
    @State private var isCalling = false
    
    // Animation properties
    let easeGently = Animation.easeOut(duration: 1).repeatForever(autoreverses: true)
    let pulsingColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    var body: some View {
        NavigationStack { // Navigation stack to allow for navigation views
            ZStack { // Stacking views on top of each other
                
                VStack { // Vertical stack for arranging views
                    
                    Spacer() // Spacer to push views to the top
                    
                    VStack { // Another vertical stack for arranging views
                        
                        ZStack { // Stacking views on top of each other
                            
                            // Outer Circle
                            Circle()
                                .fill(Color(pulsingColor).gradient)
                                .frame(width: 172, height: 172)
                                .opacity(0.1)
                                .scaleEffect(isCalling ? 0.8 : 1.2)
                                .zIndex(isCalling ? 0 : 1)
                                .animation(easeGently.delay(0.2), value: isCalling)
                            
                            // Middle Circle
                            Circle()
                                .fill(Color(pulsingColor).gradient)
                                .frame(width: 152, height: 152)
                                .opacity(0.2)
                                .scaleEffect(isCalling ? 0.7 : 1.1)
                                .zIndex(isCalling ? 0 : 3)
                                .animation(easeGently.delay(0.8), value: isCalling)
                            
                            // Inner Circle
                            Circle()
                                .fill(Color(pulsingColor).gradient)
                                .frame(width: 172, height: 172)
                                .opacity(0.3)
                                .zIndex(isCalling ? 0 : 3)
                                .scaleEffect(isCalling ? 0.5 : 1.2)
                                .animation(easeGently.delay(0.6), value: isCalling)
                            
                            // Image for the caller
                            Image(.kapil)
                                .resizable()
                                .frame(width: 220, height: 190)
                                .hueRotation(Angle(degrees: isCalling ? 0 : .random(in: 0...120)))
                                .clipShape(Circle())
                                .opacity(isCalling ? 1 : 0.1)
                                .scaleEffect(isCalling ? 1 : 0.5)
                                .animation(easeGently, value: isCalling)
                        }
                        .onAppear {
                            // Trigger animation on view appearance
                            withAnimation {
                                isCalling.toggle()
                            }
                        }
                        
                        // Text for caller's name
                        Text("Kapil Soni")
                            .font(.title)
                        
                        // HStack for "Calling" text and ellipsis symbol
                        HStack(alignment: .bottom, spacing: 5) {
                            Text("Calling")
                            Image(systemName: "ellipsis")
                                .symbolEffect(
                                    .variableColor.iterative.reversing
                                )
                                .foregroundStyle(
                                    EllipticalGradient(colors:[Color(pulsingColor), .green], center: .center, startRadiusFraction: 0.0, endRadiusFraction: 0.5)
                                )
                                .hueRotation(.degrees(isCalling ? 0 : 300))
                                .animation(easeGently.delay(0.6), value: isCalling)
                        }
                        .font(.title3)
                        .bold()
                        
                    }
                    
                    Spacer() // Spacer to push views to the bottom
                    
                    HStack { // Horizontal stack for arranging views
                        
                        // Image for declining the call
                        Image(systemName: "phone.down.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 80))
                        
                        Spacer() // Spacer to separate images
                        
                        // Image for accepting the call
                        Image(systemName: "phone.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 80))
                    }
                    .padding(EdgeInsets(top: 0, leading: 48, bottom: 16, trailing: 48)) // Padding for the HStack
                    
                }
                .toolbar { // Toolbar for navigation items
                    
                    // Leading navigation items
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            print("Pressed back arrow button")
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                        
                        Button("Messages") {
                            print("Pressed messages button")
                        }
                    }
                    
                    // Trailing navigation item
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            print("Pressed person button")
                        } label: {
                            Image(systemName: "person.3.fill")
                        }
                    }
                }
            }
        }
    }
}

//#Preview { // Previewing the view
//    CustomCaller()
//        .preferredColorScheme(.dark) // Setting preferred color scheme to dark
//}
