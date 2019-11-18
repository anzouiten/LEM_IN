COUNT=5
X=1
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

printf "${GREEN}==================\n%s\n==================${NC}\n" "BIG"
while [ $X -le $COUNT ]
do
    printf "${YELLOW}TRY %d${NC}\n" $X
    ./generator --big | ./test > test.txt
	printf "%-12s%d\n" "ANTS:" $(head -n 1 test.txt)
	printf "%-12s%d\n" "ROOMS:" $(grep "[0-99999][[:space:]][0-99999]" test.txt | wc -l)
    printf "%-12s" "ANSWER:"
    grep -m 1 "#Here is the number of lines required:" test.txt | cut -d ":" -f 2 | awk '{$1=$1};1'
    printf "%-12s" "OUR ANSWER:"
    grep "^L" test.txt | wc -l | awk '{$1=$1};1'
    start=$(date +%s)
    ./lem-in < test.txt > /dev/null
    end=$(date +%s)
    runtime=$((end-start))
    printf "%-12s" "RUNTIME:"
    echo $runtime
    X=$(( $X + 1 ))
	rm test.txt
done
