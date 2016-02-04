
This is an iOS app that uses [neural-style](https://github.com/jcjohnson/neural-style) to apply a style from one image (usually a painting) to another image (usually a photograph).

See [screenshots](https://github.com/tleyden/deepstyle-ios/tree/master/screenshots)

![](https://raw.githubusercontent.com/tleyden/deepstyle-ios/master/screenshots/fb_login_1.png)


Status: pre-pre-alpha

## Pre-requisites to build

* Xcode 7
* [Carthage](https://github.com/Carthage/Carthage)

## Instructions to build

Clone the repo:

```
$ git clone <repo-url>
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

* Install [Couchbase Sync Gateway](https://github.com/couchbase/sync_gateway)
* Install the [accompanying backend module](https://github.com/tleyden/deepstyle) 