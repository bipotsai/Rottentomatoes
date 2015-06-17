# Rottentomatoes
Project Requirements
* [@] User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
* [@] User can view movie details by tapping on a cell.
* [@] User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at http://cocoapods.wantedly.com?q=hud.
* [@] User sees error message when there's a networking error. You may not use UIAlertView or a 3rd party library to display the error. See this screenshot for what the error message should look like: network error screenshot.
* [@] User can pull to refresh the movie list. Guide: Using UIRefreshControl
* [] Add a tab bar for Box Office and DVD. (optional)
* [] Implement segmented control to switch between list view and grid view (optional)
Hint: The segmented control should hide/show a UITableView and a UICollectionView
* [] Add a search bar. (optional)
Hint: Consider using a UISearchBar for this feature. Don't use the UISearchDisplayController.
* [] All images fade in (optional)
    Hint: Use the - (void)setImageWithURLRequest:(NSURLRequest *)urlRequest method in AFNetworking. Create an additional category method that has a success block that fades in the image. The image should only fade in if it's coming from network, not cache.
* [] For the large poster, load the low-res image first, switch to high-res when complete (optional)
* [] Customize the highlight and selection effect of the cell. (optional)
* [] Customize the navigation bar. (optional)

![Video Walkthrough](rottentomatoes.gif)
