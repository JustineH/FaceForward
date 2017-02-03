# About FaceForward
FaceForward is an iOS app that helps users set out each day on their own terms. It uses Microsoft Cognitive Services' Emotion API to give users an analysis of their current emotional state. Then, based on the user’s primary emotion that was determined from their selfie, the app provides some guidance on how best to greet the day, and gives the user the option to play a suggested streaming radio station from SHOUTcast to lift their current mood (or maintain it), or choose another radio station by shuffling through more stations. After doing a facial analysis, and before starting their day, the user can make a conscious decision to tackle work, a project, a relationship etc. head on, or understand that they may not be in the best state to deal with confrontation and decide to mitigate stressful situations.

Users can choose to later check in and do another analysis to see how they are feeling, and if there have been any changes in their mood. All of their assessment readings are tracked in a calendar that they can then look back on to reflect on their previous states. While we do not claim that this is scientifically proven, FaceForward gives a non-biased analysis of a user’s current emotional state, allowing them to evaluate how they interact with others, and allow them the opportunity to improve their mood and put their best face forward. 

## Get it on the App Store
Coming soon to the App Store. Stay tuned!

### If you'd like to contribute to the project, here's what you'll need...

### Installation

#### Frameworks:
+ AVFoundation
+ MediaPlayer

#### Pods:
+ [JTAppleCalendar](https://cocoapods.org/pods/JTAppleCalendar)
+ [Charts](https://cocoapods.org/pods/charts)
+ [RealmSwift](https://cocoapods.org/pods/Realm)
+ [SwiftyJSON](https://cocoapods.org/pods/SwiftyJSON)
+ [Alamofire](https://cocoapods.org/pods/Alamofire)

#### APIs:
+ [Microsoft Cognitive Services' Emotion API](https://www.microsoft.com/cognitive-services/en-us/emotion-api)
+ [SHOUTcast](https://www.shoutcast.com/)

#### Necessary Environment Variables
* `microsoftKey`

* [Suggestions.randomizeSuggestions](../master/FaceForward/SuggestionsViewController.swift) = guidance or pick-me-ups based on largest emotion read from facial scan
* [RadioStations.changeStation](../master/FaceForward/RadioPlayer.swift) = streaming radio stations from SHOUTcast

## Contact
If you have any questions, comments, or feedback, please send us an email: <faceforwardapp@gmail.com>.