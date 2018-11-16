# BEGIN ANSIBLE MANAGED BLOCK bash_profile 
# include every .sh file in your ~/.profile.d in sort order
for i in $(ls ~/.profile.d/*.sh | sort) ; do
    if [ -r "$i" ]; then
      . $i
    fi
done
# END ANSIBLE MANAGED BLOCK bash_profile
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
