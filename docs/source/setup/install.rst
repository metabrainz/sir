Installation
------------


Git
~~~

If you want the latest code or even feel like contributing, the code is
available on `Github <https://github.com/mineo/sir>`_.

You can easily clone the code with git::

    git clone git://github.com/mineo/sir.git

Now you can start hacking on the code or install it system-wide::

    python2 setup.py install

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

