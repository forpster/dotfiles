if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # make brew completitions work
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

##
# Your previous /Users/rkirk/.zprofile file was backed up as /Users/rkirk/.zprofile.macports-saved_2023-05-19_at_09:48:28
##

# MacPorts Installer addition on 2023-05-19_at_09:48:28: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
