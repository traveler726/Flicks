# Flicks Project

Flicks project will pull movies from the movies db with two flavors:
* Now Playing
* Top Rated.

Submitted by: Jennifer Beck

Time spent: 24 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can view a list of movies currently playing in theaters from The Movie Database.
* [x] User can view movie details by tapping on a cell.
* [x] User sees loading state while waiting for movies API. You can use one of the 3rd party libraries listed on CocoaControls.
* [x] User sees an error message when there's a networking error.
* [x] User can pull to refresh the movie list.
* [x] Add a tab bar for Now Playing or Top Rated movies.
* [x] Implement a Grid View
* [x] Implement a UISegmentedControl to switch between a list view and a grid view.
* [x] Grid view hooked up to detailed view.

The following **optional** features are implemented:

* [ ] Add a search bar.
* [ ] All images fade in as they are loading.
* [ ] For the large poster, load the low-res image first and switch to high-res when complete.
* [ ] Customize the highlight and selection effect of the cell.
* [ ] Customize the navigation bar.
* [ ] Tapping on a movie poster image shows the movie poster as full screen and zoomable.
* [ ] User can tap on a button to play the movie trailer.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough 

Here's a walkthrough of implemented user stories:
<img src='https://github.com/traveler726/Flicks/blob/master/VideoWalkthrough.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
* Objective-C takes a lot of getting used to
* ScrollView layering is hard to understand.
* Layout and offsets in general is confusing.
* UI Work on Main Thread
* High-Level overview of what each step is trying to acheive
* Where to put the seque for push to the grid was a mystery
* Very difficult to know where things get connected (i.e. refresh control on table/etc.)

## License

    Copyright [2017] [Jennifer Beck]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
