
This is an iOS app that uses [neural-style](https://github.com/jcjohnson/neural-style) to apply a style from one image (usually a painting) to another image (usually a photograph).

See [screenshots](https://github.com/tleyden/deepstyle-ios/tree/master/screenshots)

Status: pre-pre-alpha

## Pre-requisites to build

* Xcode 7
* [Carthage](https://github.com/Carthage/Carthage)

## Instructions to build

```
$ git clone <repo-url>
$ carthage bootstrap
```

## Deploying

* Install [Couchbase Sync Gateway](https://github.com/couchbase/sync_gateway)
* Install the [accompanying backend module](https://github.com/tleyden/deepstyle) 