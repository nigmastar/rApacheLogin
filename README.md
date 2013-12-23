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
