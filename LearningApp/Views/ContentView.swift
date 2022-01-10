//
//  ContentView.swift
//  LearningApp
//
//  Created by ANGEL RAMIREZ on 1/8/22.
//

import SwiftUI
struct ContentView: View {
    
    @EnvironmentObject var model:ContentModel
    var body: some View {
        ScrollView{
            
            LazyVStack{

                // Confirm that currentoModule is set
                
                if model.currentModule != nil{
                    ForEach(0..<model.currentModule!.content.lessons.count){index in
                        
                        NavigationLink(destination:
                                        ContentDetailView()
                                            .onAppear(perform: {model.beginLesson(index)}),
                                       
                                       label: {
                            
                            ContentViewRow(index: index)
                            
                        })
                       
                    
                }
                
                    
                    
                    
                    
                }
                
                
            }
            .padding()
            .navigationBarTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

