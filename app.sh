# Empty the error listing
> file_failures.txt
{ while IFS=';' read  h1 u1 p1 h2 u2 p2 extra fake
    do 
        line_counter=`expr 1 + $line_counter` 
        { echo "$h1" | tr -d '\r' | egrep '^#|^ *$' ; } > /dev/null && continue # this skip commented lines in file.txt
        echo "==== Starting imapsync with --host1 $h1 --user1 $u1 --host2 $h2 --user2 $u2 $extra $@ ===="
        if imapsync --host1 "$h1" --user1 "$u1" --password1 "$p1" \
                    --host2 "$h2" --user2 "$u2" --password2 "$p2" $extra "$@" 
        then
                echo "success sync for line $line_counter "
        else
                echo "$h1;$u1;$p1;$h2;$u2;$p2;$extra;" | tee -a file_failures.txt
        fi 
        echo "==== Ended imapsync with --host1 $h1 --user1 $u1 --host2 $h2 --user2 $u2 $extra $@ ===="
        echo
    done
} < lista.txt