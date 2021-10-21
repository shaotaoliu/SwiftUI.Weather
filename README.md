# SwiftUI.Weather

This app is very similar to the weather app in iPhones. When it starts, it shows the weather of a list of cities. The cities are stored in UserDefaults (@AppStorage) so that you don't need to re-enter them when the app restarts.

![image](https://user-images.githubusercontent.com/15805568/137261762-e9df6205-5f53-421d-9e65-01bd1338c0a6.png)

Clicking °C/°F on the left-top corner will switch between celsius and fahrenheit.

![image](https://user-images.githubusercontent.com/15805568/137260629-7624a143-58b6-403b-ba26-750e453469fb.png)

Clicking + on the right-top corner will show a popup where you can enter a new city. If no city is stored in UserDefaults, it will show the popup automatically instead of showing an empty list when the app starts.

![image](https://user-images.githubusercontent.com/15805568/137261149-a212cef9-49f2-4358-8e58-b9b8ee870149.png)

Selecting any city in the list will show the weather of the selected city. The interface has three parts:
1. The top part shows the current weather of the city.
2. The middle part shows the weather of next 24 hours.
3. The bottom part shows the weather of next 7 days.

![image](https://user-images.githubusercontent.com/15805568/137261459-6cade5af-e37f-485f-bef0-e9e23280f988.png)

This app also shows how to use:
1. MVVM
2. DispatchGroup to fetch weathers for multiple cities concurrently (That's why the order of the cities in the list is random every time the app restarts)
3. App icon and launch screen
4. ProgressView
5. fullScreenCover (sheet)
6. alert
7. ButtonStyle
8. @AppStorage
9. @FocusState
10. @Environment
