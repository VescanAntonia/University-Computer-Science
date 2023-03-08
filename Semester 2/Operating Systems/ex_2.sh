w=$1
m=$2
n=$3
for (( i=4; i<=$#; i++ ))
do
   c=$(awk -v n=$n -v w=$w 'NR==n{for(i=1; i<=NF; i++) if(w==$i) count++; print count;}' ${!i})
   if [ $c -ge $m ]
   then
	echo ${!i}
   fi
done
