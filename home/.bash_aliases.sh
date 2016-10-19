alias f=finger
alias j=jobs
alias z=suspend
alias dude='xterm -bg white -fg black -e man '
alias cls='clear'
alias finduser='ypcat -k passwd | grep -i'
alias dirf='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'
alias ftype='find ${*-.} -type f | xargs file | awk -F, '\''{print $1}'\'' | awk '\''{$1=NULL;print $0}'\'' | sort | uniq -c | sort -nr'
alias cm=colmake


# Size of folders
alias dux='du -sk ./* | sort -n | awk '\''BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'\'''
alias dush="du -sm *|sort -n|tail"

# get defines out of gcc!
alias whatg++='echo "main(){}" | g++ -E -x c++ -dM - '
alias whatg++0x='echo "main(){}" | g++ -std=c++0x -E -x c++ -dM - '
alias whatgcc='echo "main(){}" | gcc -E -x c -dM - '

# FILTH!
# hate doing this but i don't want ssh to take over my DISPLAY variable
# by default, so we want ssh -x as default
#alias ssh='ssh -x'

# color not supported on all platforms so overridden in platform specific
# sections later
alias ls='ls --color=auto'
alias ll='ls -lF --color'
alias ld='ls -al -d * | egrep "^d"' # only subdirectories
alias lt='ls -alt | head -20' # recently changed files
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# as we don't have a password generator at work any more
alias pwgen='apg -m 12 -x 12 -M SNCL'

alias sd='svn diff --diff-cmd /usr/bin/meld'
alias svnrepodiff="svn diff -r BASE:HEAD"

alias remove_emacs_backup='find . -name "*~" -delete'
alias ec='emacsclient -n'
