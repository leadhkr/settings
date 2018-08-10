# BEGIN ANSIBLE MANAGED BLOCK bash_profile 
# include every .sh file in your ~/.profile.d in sort order
for i in $(ls ~/.profile.d/*.sh | sort) ; do
    if [ -r "$i" ]; then
      . $i
    fi
done
# END ANSIBLE MANAGED BLOCK bash_profile