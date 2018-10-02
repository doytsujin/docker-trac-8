# docker-trac
Sample Docker for running Trac with a single project (personal project tracking).

For those stumbling upon this repo, please do not take anything about the Docker
setup as holy writ.  This setup is highly opinionated and based upon some tinkering
that I had been doing with Trac, trying to set up a (relatively) simple personal
project tracker.  It is by no means designed to be a production-capable service,
nor should it be used as such.  This is merely a sample setup for demonstration
purposes.

If you decide to try the image, it is available on Docker hub:

```sh

    $ docker pull techchihuahua/trac-single:1.2.3-alpine

```

This image is based on the 1.2.3 version of Trac, and using the current latest
Python 2 alpine image.  To log in to the service once you have it up and running,
use `admin/admin` as the username and password combination.  Again, this is not
a production setup; you would never use such credentials in production, right?!

I am by no means an expert on using/administering Trac, so if anyone has
suggestions on how to improve this demo image, please feel free to contribute.

