
This is non official simple demonstration app for [octokit.objc].

This app still under construction. Please see [issue](https://github.com/naokits/OctoKitDemo/issues)

[octokit.objc]: https://github.com/octokit/octokit.objc

## Installation

See also OctoKit's [Importing OctoKit](https://github.com/octokit/octokit.objc#importing-octokit)



```
% cd OctoKitDemo
% git submodule add -f https://github.com/octokit/octokit.objc.git OctoKit
% cd OctoKit
% script/bootstrap

*** Checking dependencies...
*** Updating submodules...
Submodule 'External/AFNetworking' (https://github.com/AFNetworking/AFNetworking.git) registered for path 'External/AFNetworking'
Submodule 'External/ISO8601DateFormatter' (https://github.com/boredzo/iso-8601-date-formatter.git) registered for path 'External/ISO8601DateFormatter'
Submodule 'External/Mantle' (https://github.com/MantleFramework/Mantle.git) registered for path 'External/Mantle'
Submodule 'External/OHHTTPStubs' (https://github.com/github/OHHTTPStubs.git) registered for path 'External/OHHTTPStubs'
Submodule 'External/ReactiveCocoa' (https://github.com/ReactiveCocoa/ReactiveCocoa.git) registered for path 'External/ReactiveCocoa'
Cloning into 'External/AFNetworking'...
remote: Reusing existing pack: 8286, done.
remote: Counting objects: 809, done.
remote: Compressing objects: 100% (379/379), done.
remote: Total 9095 (delta 526), reused 704 (delta 430)
Receiving objects: 100% (9095/9095), 4.42 MiB | 15.00 KiB/s, done.
Resolving deltas: 100% (5171/5171), done.
Checking connectivity... done
Submodule path 'External/AFNetworking': checked out '4b79bd91ed3e53ca04e68314be1ecca60dc90683'
Cloning into 'External/ISO8601DateFormatter'...
remote: Reusing existing pack: 854, done.
remote: Total 854 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (854/854), 210.79 KiB | 32.00 KiB/s, done.
Resolving deltas: 100% (506/506), done.
Checking connectivity... done
Submodule path 'External/ISO8601DateFormatter': checked out '35f4248b2747dee9716c9f59ccada16862a5278c'
Cloning into 'External/Mantle'...
remote: Reusing existing pack: 3187, done.
remote: Counting objects: 32, done.
remote: Compressing objects: 100% (27/27), done.
remote: Total 3219 (delta 16), reused 21 (delta 5)
Receiving objects: 100% (3219/3219), 879.57 KiB | 18.00 KiB/s, done.
Resolving deltas: 100% (1826/1826), done.
Checking connectivity... done
Submodule path 'External/Mantle': checked out '8aef509d18adb33775a5639eaa6dd13002095488'
Cloning into 'External/OHHTTPStubs'...
remote: Counting objects: 1258, done.
remote: Compressing objects: 100% (532/532), done.
remote: Total 1258 (delta 702), reused 1258 (delta 702)
Receiving objects: 100% (1258/1258), 463.17 KiB | 12.00 KiB/s, done.
Resolving deltas: 100% (702/702), done.
Checking connectivity... done
Submodule path 'External/OHHTTPStubs': checked out '531d96921b451499015c0075a1910eab1e04ec8c'
Cloning into 'External/ReactiveCocoa'...
remote: Reusing existing pack: 23592, done.
remote: Counting objects: 64, done.
remote: Compressing objects: 100% (44/44), done.
remote: Total 23656 (delta 33), reused 50 (delta 20)
Receiving objects: 100% (23656/23656), 9.37 MiB | 32.00 KiB/s, done.
Resolving deltas: 100% (11600/11600), done.
Checking connectivity... done
Submodule path 'External/ReactiveCocoa': checked out '74ebd6de5138d68469f59ef5faccfe083919912f'
*** Bootstrapping External/Mantle...
Cloning into 'Configuration'...
remote: Reusing existing pack: 382, done.
remote: Total 382 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (382/382), 72.96 KiB | 14.00 KiB/s, done.
Resolving deltas: 100% (117/117), done.
Checking connectivity... done
Cloning into 'MantleTests/expecta'...
remote: Counting objects: 1502, done.
remote: Compressing objects: 100% (615/615), done.
remote: Total 1502 (delta 807), reused 1502 (delta 807)
Receiving objects: 100% (1502/1502), 330.53 KiB | 26.00 KiB/s, done.
Resolving deltas: 100% (807/807), done.
Checking connectivity... done
Cloning into 'MantleTests/specta'...
remote: Counting objects: 887, done.
remote: Compressing objects: 100% (399/399), done.
remote: Total 887 (delta 441), reused 887 (delta 441)
Receiving objects: 100% (887/887), 841.80 KiB | 9.00 KiB/s, done.
Resolving deltas: 100% (441/441), done.
Checking connectivity... done
*** Bootstrapping External/ReactiveCocoa...
Cloning into 'external/expecta'...
remote: Counting objects: 1502, done.
remote: Compressing objects: 100% (615/615), done.
remote: Total 1502 (delta 807), reused 1502 (delta 807)
Receiving objects: 100% (1502/1502), 330.53 KiB | 17.00 KiB/s, done.
Resolving deltas: 100% (807/807), done.
Checking connectivity... done
Cloning into 'external/specta'...
remote: Counting objects: 887, done.
remote: Compressing objects: 100% (399/399), done.
remote: Total 887 (delta 441), reused 887 (delta 441)
Receiving objects: 100% (887/887), 841.80 KiB | 23.00 KiB/s, done.
Resolving deltas: 100% (441/441), done.
Checking connectivity... done
Cloning into 'external/xcconfigs'...
remote: Reusing existing pack: 382, done.
remote: Total 382 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (382/382), 72.96 KiB | 30.00 KiB/s, done.
Resolving deltas: 100% (117/117), done.
Checking connectivity... done
```
Then back to OctoKitDemo root directory.

You should add **AccountSettings.h** to project root directory.

```
// AccountSettings.h
static NSString * const GitHubClientID = @"YOUR_CLIENT_ID";
static NSString * const GitHubClientSecret = @"YOUR_CLIENT_SECRET";
```

and just open OctoKitDemo.xcodeproj.



# License

OctoKit is released under the MIT license. See [LICENSE.md].

[LICENSE.md]: https://github.com/Octokit/octokit.objc/blob/master/LICENSE.md

