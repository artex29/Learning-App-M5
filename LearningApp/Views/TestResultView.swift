//
//  TestResultView.swift
//  LearningApp
//
//  Created by ANGEL RAMIREZ on 1/18/22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    var numCorrect: Int
   
    var resultingHeading: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect) / Double((model.currentModule?.test.questions.count)!)
        
        if pct > 0.5 {
            
            return "Doing great"
            
        }
        else if pct > 0.3 {
            
            return "Awesome!"
        }
        else {
            
            return "Keep learning"
        }
                    
    }
    
    var body: some View {
        
        
        
        VStack{
            Spacer()
            
            Text(resultingHeading)
                .font(.title)
                .bold()
            Spacer()
            
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            
            
                
                Button {
                    
                    model.currentTestSelected = nil
                } label: {
                    
                    ZStack{
                    RectangleCard(color: Color.green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(Color.white)
                }
                    .padding()

               
            }
            
            
        }
        
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView(numCorrect: 2)
    }
}
