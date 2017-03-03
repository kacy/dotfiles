if [ -f $HOME/.sshkeys ]; then
    (ssh-add -l 2>&1) > /dev/null

    if [ $? = "1" ]; then
        cat $HOME/.sshkeys | xargs ssh-add 2> /dev/null
    fi
fi
