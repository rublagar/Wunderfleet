# Wunderfleet
Wunder Mobility iOS Coding Challenge.

### **Highlights**
- iOS 11 support.
- Swift 5.0.
- MVVM-C Pattern.
- Clean architecture: SOLID principles.
- Reactive: RxSwift / RxCocoa / RxAlamofire / RxTest / RxBlocking.
- Custom UI and assets.
- Single ViewController StoryBoard for each Module.
- User Location.
- Dependency Injection to Mock Network API Service.
- Codables
- API Postman Collection included.
- Dependencies using CocoaPods.
- XCTests.
- Localization(l10n) ready.
- Extensions
- Gitflow.
- [Trello](https://trello.com/b/LHwdBTUs/wunder-mobility-ios-coding-challenge)

### **Features**

Rent a car using Wunderfleet:

- MapView with cars annotation.
- Car detail View.
- Car Quick Rent.

### **User Manual / Installation**

- Clone or download the project.
- Pod install dependecies with CocoaPods.
- Run `Wunderfleet.xcworkspace` in Wunderfleet App folder.
- Remember to select `Wunderfleet` target to Run the app.
- Mock API data using `MockAPI()` in `AppDelegate`. Uncomment `let apiService = MockAPI()` and comment `let apiService = API()` code.


### **Screenshots**

### MapView

![MapView 01](https://raw.githubusercontent.com/rublagar/Wunderfleet/develop/Doc/Images/01.png)

![MapView 02](https://raw.githubusercontent.com/rublagar/Wunderfleet/develop/Doc/Images/02.png)

### CarDetailView

![MapView 03](https://raw.githubusercontent.com/rublagar/Wunderfleet/develop/Doc/Images/03.png)

![MapView 04](https://raw.githubusercontent.com/rublagar/Wunderfleet/develop/Doc/Images/04.png)

## Possible Future Improvements
- Reactive Coordinator.
- Include Logs.
- Improve MapView annotation Callout and View.
- Handle detailed API error messages.
- UI Tests.
- Remove all warnings.
- Fastlane for automations like app distribution or screenshots.
- Analytics.
- Real time crash reporting tool.

