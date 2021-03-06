# Setup my mac for Frontend Development
FED is a shell script to setup your MacOS for frontend development

```
(The following tools are what I mainly use. 
If you are looking for a complete set of tools I'll strongly recommend:
https://github.com/thoughtbot/laptop)
```


Requirements
------------

* macOS Sierra (10.12)

Haven't tested on older versions

Install
-------

Note: Please review the script after downloading and before executing.

```sh
curl --remote-name https://raw.githubusercontent.com/shariati/setupmymac/master/fed.sh
sh fed.sh
```

What does this script installs?
---------------

macOS tools:

* [Homebrew] The missing package manager for macOS for managing operating system libraries.

[Homebrew]: http://brew.sh/


Image tools:

* [ImageMagick] for cropping and resizing images

Tools, Package managers, and configuration:

* [JDK] (Java SE Development Kit) For Java Developers. Includes a complete JRE plus tools for developing, debugging, and monitoring.
* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [Yarn] for managing JavaScript packages
* [Rbenv] for managing versions of Ruby
* [Yeoman] Scaffolding tool for modern webapps
* [Live-Server] Little development server with live reload capability
* [Begoo] Something with style in terminal
* [Webpack] Bundle your assets, scripts, images

[JDK]: http://www.oracle.com/technetwork/java/javase/downloads/index.html
[ImageMagick]: http://www.imagemagick.org/
[Rbenv]: https://github.com/sstephenson/rbenv
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[Yarn]: https://yarnpkg.com/en/
[Yeoman]: http://yeoman.io/
[Live-Server]: https://github.com/tapio/live-server
[Begoo]: https://github.com/shariati/begoo
[Webpack]: https://github.com/shariati/begoo


Mobile:

* [Cordova] Create Mobile apps with HTML, CSS & JS Target multiple platforms with one code base.

[Cordova]: https://cordova.apache.org/


Databases:

* [MongoDB] NoSQL database program, MongoDB uses JSON-like documents with schemas

[MongoDB]: https://www.mongodb.com/


Similar Tool
------------
* [Laptop] Laptop is a script to set up a macOS laptop for web and mobile development.

[Laptop]: https://github.com/thoughtbot/laptop

Contributing
------------

Edit the `fed.sh` file.
Document in the `README.md` file.

License
-------

It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE

