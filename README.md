# Swift-Weather

This is a simple app that retrieves the current conditions and forecast for
Columbus, OH from the National Weather Service at weather.gov. We'd like you to
fix two bugs and add some missing features.

1. Bug: On iOS 8, the app is able to fetch the current conditions and display
them, but on iOS 9, it does not. The debug output says App Transport Security
blocked the load.

2. Bug: There is a lengthy delay after getting a response from the server before
the labels in the view update, and errors in the debug output about autolayout.

3. The JSON feed from NWS includes an image file to represent the current
weather. Images on the NWS server are stored in a directory at
http://forecast.weather.gov/newimages/medium/. Pull the image for the current
weather and place it above the current temperature.
 
4. The JSON feed from NWS includes a 5-day forecast. Show this forecast along
with the current weather.

5. Add something else to the app that you feel makes it better. It can be
anything. Use your imagination!
