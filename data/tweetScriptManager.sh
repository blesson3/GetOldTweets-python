d=$1
d2=$2
search=$3
fileNameFriendlySearch=${3// /_}
echo -e "Searching for $search\n"

i=0
while [ "$d" != "$d2" ]; do 
  next=$(date -I -d "$d + 1 day")
  echo "spinning up for ${d} - ${next}"
  python ../Exporter.py --querysearch "$search" --since "$d" --until "$next" --output "${fileNameFriendlySearch}_${d}_${next}.csv" > "${fileNameFriendlySearch}_${d}_${next}_log.out" &
  
  d=$next
  i=$((i+1))
  if [ "$(expr "$i" % 30)" -eq "0" ]; then
    echo "waiting for processes to finish..."
    wait
    echo -e "processes have finished.\n"
  fi
done

wait
echo "All processes finished"
