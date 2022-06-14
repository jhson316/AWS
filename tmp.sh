#!/bin/bash

# for (( i=1 ; i < 2; i++ ))
# do
#     # grep resource *"-$i.tf" | awk '{print "sed -i \"s/\\"$3}' | sed "s/\"$/-$i\" \*-$i.tf/g"
#     grep resource *"-$i.tf" | awk '{print $3}' #| sed "s/\"$/-$i\" \*-$i.tf/g"
#     echo ""
# done
for (( i=1 ; i <= 1 ; i++ ))
do
    for j in $( cat tmp.txt )
    do
        echo $j | awk '{ print "sed -i \"s/"$1"/"$1"-2/g\" AWS_private-2.tf" }'
        # sed "s/$j/$j-$i/g" *"-$i.tf" | grep resource | awk '{ print $3 }'
    done
    echo ""
done