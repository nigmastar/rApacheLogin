rApacheLogin
============

Login form using rApache and svSocket
-----------------------

This simple web site contains a login form and an index web pages which can be 
used to display any result from an R script only to those users having a password.

### setting up the files

Save these file in a folder called 'rApacheLogin' under your localhost folder (which
in general is /var/www/).

- login.html
- checklogin.html
- index.html
- logout.html


### Apache setting

Once saved the above files in /var/www/rApacheLogin
go to your apache setting, /etc/apache2/httpd.conf
and add these lines

```
REvalOnStartup "library(brew)"

<Directory /var/www/rApacheLogin>
	DirectoryIndex index.html
        <Files "?*">
            	SetHandler r-script
		RHandler brew::brew
        </Files>
</Directory>
```

Probably you already have the first one.


### Server set-up

Differently than Rook, where all requested files are parsed in the same environment,
in rApache no variables are guaranteed to be alive in a new page request. A simple
usage of this would be a hit counter, where you count how many hits (possibly per
users) a page had. In PHP this is possible without any server connection to store
the counts. In Rook is possible even without assigning to the global environment.
A normal `count <- count + 1` will suffice.

Even though the R internal web server is anything but powerful Rook is based on
(just not meant for production), the way Rook works gives users an incredible help
in setting up very quickly a web application showing a shed full of data. Being the
environment rook requests are responsed inside a normal rsession users can benefit
from having your webserver, your server-side scripting, your database server all in the
same place. No connections to other application are needed (for small/internal projects).
From personal experience Rook is capable to serve more than 10 users at the same time,
each of them requesting some table joins using data.table followed by some stats and
ggplot creation. However to increase this capabilities and have more functionalities
rApache is a natural move. In rApache you'll have basically everytihing Apache http
can offer you. Security in primis.

To have the possibility to store data in rApache, accross different page requests we
need a database connection. An rsession can function like that thanks to [svSocket package](http://cran.r-project.org/web/packages/svSocket/index.html). We just have to
open an r session and run:

```
require(svSocket)
startSocketServer()
```

and it's done. You can also change the default 8888 port to which the r socket server
listens to and other parameters, please check `?startSocketServer`. Every time a file
is brew()ed, if needed, we can connect to the above mentioned rsession (left
constantly open) by adding

```
require(svSocket)
con <- socketConnection(host = "localhost", port = 8888, blocking = FALSE)
```

on top of the scripts. If your apache web server and the r socket server are in different
server just specify the ip via the host parameter.














