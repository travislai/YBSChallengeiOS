<!-- ABOUT THE PROJECT -->

## About The Challenge

- Written in SwiftUI
- Using Swift Concurrency (Probably will be quicker if not using Swift Concurrency)

### HomeView

- Default search value is set to "yorkshire"
- "flickr.photos.search" api is call in "onAppear"
- "flickr.photos.getInfo" api is call base on the result of "flickr.photos.search"
- Tap on a photo, a Sheet View will show for more details of the selected photo.
- "ImageLoader" handles all the api calls

### PhotoDetailsView

- To show more details about the selected photo

<!-- THINGS TO IMPROVE -->

## Things to improve

- The api calls are very slow. It should be using a lazy loading to retrieve the Photo Info or do it by batches.
- Snapshot Test is not working.
- Additional features are not added.
- I was using the wrong api. I have wasted a bit of time on that.
- Got distracted by the England game.

### Package Added

- swift-snapshot-testing
