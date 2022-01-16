//
//  ContentModel.swift
//  LearningApp
//
//  Created by ANGEL RAMIREZ on 1/5/22.
//

import Foundation
import SwiftUI

class ContentModel:ObservableObject {
    
    // List of Modules
    @Published var modules = [Module]()
    
    // Current Module
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var codeText = NSAttributedString()
    
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    
    @Published var currentTestSelected: Int?
    
    init(){
        
        getLocalData()
    }
    
    // MARK: - Data Methods
    
    func getLocalData(){
        
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do{
        
            let jsonData = try Data(contentsOf: jsonURL!)
            
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            
            self.modules = modules
        }
        catch{
            
            print("Couldn't parse local data")
        }
        
        
        
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleURL!)
            self.styleData = styleData
            
        }
        catch{
            print("Couldn't parse style data")
            
        }
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleId: Int){
        
        // Find the index for this module ID
        for index in 0..<modules.count{
   
            if modules[index].id == moduleId{
                
                // Found the matching module
                
                currentModuleIndex = index
                
                break
                
                
            }
        }
        
        // Set the current module
        
        currentModule = modules[currentModuleIndex]
    }
    
    
    func beginLesson(_ lessonIndex:Int){
        
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count{
            
            currentLessonIndex = lessonIndex
        }
        else{
            
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        codeText = addStyling(currentLesson!.explanation)
    }
    
    
    func nextLesson() {
        
        // Advance the lesson index
        
        currentLessonIndex += 1

        // Check that it is in range
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
        
        
        
        
        
    }
    
    func hasNextLesson() -> Bool {
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            
            return true
            
        }
        else {
            
            return false
        }
    }
    
    
    func beginTest(_ moduleID: Int) {
        
        // Set the current module
        beginModule(moduleID)
        
        // Set the current question index
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0  {
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            
            // Set the question content as well
            codeText = addStyling(currentQuestion!.content)
        
            
        }
        
        
        
        
    }
    
    // MARK: Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        
        if styleData != nil {
            
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        //Convert the atributed string
        
      
            if  let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
                
                resultString = attributedString

        }
       
        
        
        
        return resultString
    }
}
