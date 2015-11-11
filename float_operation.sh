t=0.10
m=100.
sig=$(expr $t*$m | bc)
echo "$sig"

 rhov=`echo "scale=10; ($rhol/$rrho)" | bc -l`
