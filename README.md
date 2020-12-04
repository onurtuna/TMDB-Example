# TMDB-Example

IMPORTANT: Please, make sure that you have provided an api key from themoviedb.org inside the Key.plist file. I do not prefer to provide the key within the code as this is a public repo.

A brief description of the project code:

- The project uses MVVM pattern. The api call is made inside the MovieViewModel class.
- URLSession is used for networking to avoid use of 3rd party libraries. I'd prefer to use Moya for its flexible use.
- The api response is decoded via a Codable struct.
- A collection view is used to list the movies. It provides a flexible list/grid transition.
- The images of the movies are downloaded / cached after waking / reusing cells.
- Image caching is handled using NSCache via a dedicated thread called "cacheImageQueue".
- Pagination is handled upon a button click. The results are appended to the fetched movies.
- Search is handled by SearchController which is assigned to the MovieCollectionView.
- No StoryBoard is used in the project except LaunchStoryBoard.
- The starting view controller is a navigation controller with a root view controller of MoviesViewController.
- Unit classes are provided with the code with a code coverage of around 60%.
