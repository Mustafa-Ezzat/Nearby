# Nearby

An iOS app for displaying realtime nearby places  around you.

# Table of Contents:
- [Problem](#problem)
- [Solution](#solution)
- [Testing](#testing)
- [Installation](#installation)
- [Third parties](#Third-parties)
- [Future](#future)
- [References](#references)

## Problem

App uses [Foursquare API](https://developer.foursquare.com/docs/) to display user’s nearby places in a simple list, each place in the list contains:
- Place Name
- Place Address
- Place Photo

## Solution

Breaking down a problem into smaller subproblems:

- Fetch the nearby places
- Fetch the list of pictures for each place
- Caching the nearby places
- Handle errors

## Testing

TDD is self-documentation for your product, it is when your tests are written before your implementation. These are the TDD three Laws: 1) (RED) Write a failing test 2) (Green) Make the test pass 3) Refactor your code. 

Testing is the self-documentation for each piece of the problem:

- [Fetch places](https://github.com/Mustafa-Ezzat/Nearby/blob/master/Nearby/NearbyTests/PlaceFetcherTestCase.swift)
- [Decode places response](https://github.com/Mustafa-Ezzat/Nearby/blob/master/Nearby/NearbyTests/ExploreResponsableTestCase.swift)
- [Fetch photos](https://github.com/Mustafa-Ezzat/Nearby/blob/master/Nearby/NearbyTests/PlacePhotoFetcherTestCase.swift)
- [Decode place's photos response](https://github.com/Mustafa-Ezzat/Nearby/blob/master/Nearby/NearbyTests/PhotoListResponsableTestCase.swift)
- [Cache places](https://github.com/Mustafa-Ezzat/Nearby/blob/master/Nearby/NearbyTests/RealmWorkerTestCase.swift)

Search support prefix, infix, and postfix.

## Installation
- You have Xcode installed
- Open your terminal 
- 'git clone https://github.com/Mustafa-Ezzat/Nearby.git'

Hints: I recommend using ssh in other situations

## Third parties
- [Nuke](https://github.com/kean/Nuke) is a powerful image loading and caching system
- [Unrealm](https://github.com/arturdev/Unrealm) is powerful caching swift library written over RealmCocoa, which enables Swift native types to be saved in Realm.
- [SwiftLint](https://github.com/realm/SwiftLint) is a tool to enforce Swift style and conventions.

Hint: [cocoapods](https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control) community recommends against adding the Pods directory to your [.gitignore](https://github.com/Mustafa-Ezzat/Movielix/blob/master/.gitignore).

## Future
- I recommend using [Quick](https://github.com/Quick/Quick) and [Nimble](https://github.com/Quick/Nimble) to write clear self-documentation test cases.

## References

- [Clean swift architecture](https://clean-swift.com/)
- [The SOLID principles](https://www.youtube.com/watch?v=ltyI-o3DFtQ)
