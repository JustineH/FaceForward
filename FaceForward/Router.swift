//
//  Router.swift
//  FaceForward
//
//  Created by carmen cheng on 2016-12-15.
//
//

import UIKit
import RealmSwift

class Router: NSObject {

    //MARK: Properties
    var vc: UIViewController?

    //MARK: Object Life Cycle
    convenience init(_ vc: UIViewController) {
        self.init()
        self.vc = vc
    }


    //MARK: Public Functions
    func showMain() {
        vc?.show(Router.mainVC(), sender: vc)
    }

    func showSurvey() {
        vc?.show(Router.surveyVC(), sender: vc)
    }

    func showPhoto(survey: Survey) {
        let photoVC = Router.takePictureVC()
        photoVC.survey = survey
        vc?.show(photoVC, sender: vc)
    }

    func showSuggestions(emotion: String) {
        let suggestionsVC = Router.suggestionsVC()
        suggestionsVC.emotionForSuggestion = emotion
        vc?.show(suggestionsVC, sender: vc)
    }

    func showChart(dict: Emotion) {
        let chartVC = Router.chartVC()
        chartVC.dict = dict
        vc?.show(chartVC, sender: vc)
    }
    
    func showDetail(date: Date) {
        let detailVC = Router.detailVC()
        detailVC.date = date
        vc?.show(detailVC, sender: vc)
    }


    //MARK: VCs
    fileprivate class func mainVC() -> CalendarViewController {
        return main().instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
    }

    fileprivate class func surveyVC() -> SurveyViewController {
        return survey().instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
    }

    fileprivate class func takePictureVC() -> TakePictureViewController {
        return photo().instantiateViewController(withIdentifier: "TakePictureViewController") as! TakePictureViewController
    }

    fileprivate class func suggestionsVC() -> SuggestionsViewController {
        return suggestions().instantiateViewController(withIdentifier: "SuggestionsViewController") as! SuggestionsViewController
    }

    fileprivate class func chartVC() -> AnalysisChartViewController {
        return chart().instantiateViewController(withIdentifier: "AnalysisChartViewController") as! AnalysisChartViewController
    }
    
    fileprivate class func detailVC() -> DetailLogViewController {
        return detail().instantiateViewController(withIdentifier: "DetailLogViewController") as! DetailLogViewController
    }


    //MARK: Storyboards
    fileprivate class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle:nil)
    }

    fileprivate class func survey() -> UIStoryboard {
        return UIStoryboard(name: "Survey", bundle:nil)
    }

    fileprivate class func photo() -> UIStoryboard {
        return UIStoryboard(name: "Photo", bundle:nil)
    }

    fileprivate class func suggestions() -> UIStoryboard {
        return UIStoryboard(name: "Suggestions", bundle:nil)
    }

    fileprivate class func chart() -> UIStoryboard {
        return UIStoryboard(name: "Chart", bundle:nil)
    }

    fileprivate class func musicPlayer() -> UIStoryboard {
        return UIStoryboard(name: "MusicPlayer", bundle:nil)
    }
    
    fileprivate class func detail() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}
