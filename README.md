
This is an iOS app that uses [neural-style](https://github.com/jcjohnson/neural-style) to apply a style from one image (usually a painting) to another image (usually a photograph).

It's built on top of [Couchbase Lite iOS](https://github.com/couchbase/couchbase-lite-ios) and the open source [Couchbase Mobile](http://mobile.couchbase.com) mobile database product suite.

<img src="https://raw.githubusercontent.com/tleyden/deepstyle-ios/master/screenshots/deepstyle_screenshots_animated.gif" width="400">


## Pre-requisites to build

* Xcode 7
* [Carthage](https://github.com/Carthage/Carthage)

## Instructions to build

Clone the repo:

```
$ git clone <repo-url>
```

Install Carthage:

```
$ brew install carthage
```

Get the Carthage dependencies:

```
$ carthage bootstrap
```

Add the following environment variables to your `~/.bash_profile`:

```
export DEEPSTYLE_FB_APP_ID=<your facebook app id>
export DEEPSTYLE_FABRIC_APP_ID=<your fabric app id>
export DEEPSTYLE_FABRIC_APP_SECRET=<your fabric app secret>
```

Open XCode and build.


## Deploying

* Install [Couchbase Sync Gateway](https://github.com/couchbase/sync_gateway) and use [this Sync Gateway config](https://github.com/tleyden/deepstyle/blob/master/docs/sync-gateway-config.json) 
* Install the [accompanying backend module](https://github.com/tleyden/deepstyle)

