
#### PS1 customization ####
NONE="\[\033[0m\]"    # unsets color to term fg color

# regular colors
K="\[\033[0;30m\]"    # black
R="\[\033[0;31m\]"    # red
G="\[\033[0;32m\]"    # green
Y="\[\033[0;33m\]"    # yellow
B="\[\033[0;34m\]"    # blue
M="\[\033[0;35m\]"    # magenta
C="\[\033[0;36m\]"    # cyan
W="\[\033[0;37m\]"    # white

# emphasized (bolded) colors
EMK="\[\033[1;30m\]"
EMR="\[\033[1;31m\]"
EMG="\[\033[1;32m\]"
EMY="\[\033[1;33m\]"
EMB="\[\033[1;34m\]"
EMM="\[\033[1;35m\]"
EMC="\[\033[1;36m\]"
EMW="\[\033[1;37m\]"

# background colors
BGK="\[\033[40m\]"
BGR="\[\033[41m\]"
BGG="\[\033[42m\]"
BGY="\[\033[43m\]"
BGB="\[\033[44m\]"
BGM="\[\033[45m\]"
BGC="\[\033[46m\]"
BGW="\[\033[47m\]"


# displays only the last 25 characters of pwd
set_new_pwd() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}


# the dirty status of the git repository
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "´"
}

# the name of the git branch in the current directory
set_git_branch() {
    unset GIT_BRANCH
    local branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`;
    
    if test $branch
        then
            GIT_BRANCH="${EMG}git:${NONE}$branch${EMR}$(parse_git_dirty) "
    fi
}

# the name of the activated virtual env
set_virtual_env_base() {
    unset VIRTUAL_ENV_BASE
    local venv=`basename "$VIRTUAL_ENV"`
    
    if test $venv
        then
            VIRTUAL_ENV_BASE="${EMG}env:${NONE}$venv "
    fi
}

update_prompt() {
    set_new_pwd
    set_git_branch
    set_virtual_env_base
    PS1="${EMB}[${NONE}$(id -un)@${EMM}$(hostname) ${NONE}${NEW_PWD}${EMB}] ${GIT_BRANCH}${VIRTUAL_ENV_BASE}${B}\$ ${NONE}"
}

PROMPT_COMMAND=update_prompt

# Poor man's pipe :(
function subdiff()
{
    #"$@" > ~/$$.diff
    git diff > /tmp/$$.diff
    subl /tmp/$$.diff &
    sleep 1
    rm /tmp/$$.diff
}