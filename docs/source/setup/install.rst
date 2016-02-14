Installation
------------


Git
~~~

If you want the latest code or even feel like contributing, the code is
available on `Github <https://github.com/metabrainz/sir>`_.

You can easily clone the code with git::

    git clone git://github.com/metabrainz/sir.git

Now you can install it system-wide::

    python2 setup.py install

or start hacking on the code. To do that, you'll need to run at least::

    python2 setup version

once to generate the file ``sir/version.py`` which the code needs. This file
does not have to be added into the git repository because it only contains the
hash of the current git commit, which changes after each commit operation.

Setup
~~~~~

The easiest way to run sir at the moment is to use a `virtual environment
<http://www.virtualenv.org/en/latest/>`_. Once you have virtualenv for Python
2.7 installed, use the following to create the environment::

    virtualenv venv
    source venv/bin/activate
    pip install -r requirements.txt
    cp config.ini.example config.ini

You can now use sir via::

    python -m sir
