#!/bin/bash
#This is to process a series of cases using paraview

#Here is the input, I may want to change it to be arg from termial
dataDir=${PWD} #data directory
prefix='dragon' #name of directory
mkdir -p "$prefix"{1..10} #change here xizhong

#DoE matrix
seed1=aaa #string to be replace
seed2=bbb
seed3=ccc
#seed4=ddd
#seed5=eee
#seed6=fff
#seed7=ggg

#Let's get some color
RED='\033[0;31m'
UBlue='\e[44m'
NC='\033[0m' # No Color
#echo -e "I ${RED}love${NC} Stack Overflow\n"

#check if there is input
if [ $# -gt 0 ]; then
    echo -e "${RED}input contains $# arguments${NC}"
    if [ $# -eq 3 ]; then
        prefix=$1
        t1=$2
        t2=$3
    elif [ $# -eq 2 ]; then
        prefix=$1
        t1=$2
    elif [ $# -eq 1 ]; then
        prefix=$1
        echo -e "input: ${UBlue}$1 ${NC}"
    else
        echo -e "${RED}Something wrong with the number of input ${NC}"
        exit 0
    fi
else
    echo -e "${RED}Command line contains no arguments, we use default settings${NC}"
fi

#Now output some basic information
cd $dataDir #Enter the data file
echo -e "${RED}Hi, where are we\e[0m: $PWD?" #current folder name with full path
echo -e "Folder Name: ${PWD##*/}" #current folder name without prefix
echo -e "${RED}results name:\e[0m \e[44m${ParFile%.*}\e[0m" #vtk name to be copied
echo -e "results format?:${ParFile##*.}"  #format to be copied

#mkdir -p AllResults
j=1

for ((i=$j; i<=10; i++))
do
  dir_name="${prefix}${i}"

  if [ -d "$dir_name" ]
  then
      dataDirFull="$dataDir/$dir_name"
      #cp dragon_bath.json $dataDirFull
      cp -rf ./SPH_Taichi-master1/* $dataDirFull
      cd "$dir_name"
      seed=$RANDOM
	  rep1=$(awk -v min=0.300 -v max=0.340 -v seed=$seed 'BEGIN{srand(seed); print min+rand()*(max-min)}')
	  seed=$RANDOM
	  rep2=$(awk -v min=0.300 -v max=0.340 -v seed=$seed 'BEGIN{srand(seed); print min+rand()*(max-min)}')
	  seed=$RANDOM
	  rep3=$(awk -v min=0.300 -v max=0.340 -v seed=$seed 'BEGIN{srand(seed); print min+rand()*(max-min)}')
	  #seed=$RANDOM
	  #rep4=$(awk -v min=0.250 -v max=0.270 -v seed=$seed 'BEGIN{srand(seed); print #min+rand()*(max-min)}')
	  #seed=$RANDOM
	  #rep5=$(awk -v min=0.250 -v max=0.270 -v seed=$seed 'BEGIN{srand(seed); print #min+rand()*(max-min)}')
	  #seed=$RANDOM
	  #rep6=$(awk -v min=0.250 -v max=0.270 -v seed=$seed 'BEGIN{srand(seed); print #min+rand()*(max-min)}')

      sed -i 's/'"$seed1"'/'"${rep1}"'/g' dragon_bath.json
      sed -i 's/'"$seed2"'/'"${rep2}"'/g' dragon_bath.json
      sed -i 's/'"$seed3"'/'"${rep3}"'/g' dragon_bath.json
      #sed -i 's/'"$seed4"'/'"${rep4}"'/g' dragon_bath.json
      #sed -i 's/'"$seed5"'/'"${rep5}"'/g' dragon_bath.json
	  #sed -i 's/'"$seed6"'/'"${rep6}"'/g' dragon_bath.json
	  #sed -i 's/'"$seed7"'/'"${rep7}"'/g' dragon_bath.json
      #python batch_save_twoPic.py --$dataDirFull $i $STLFile $ParFile $t1  #此处改为运行python 命令
      echo -e "${RED} Runing in $i ${NC}"
	  python run_simulation.py --scene_file dragon_bath.json

	  j=$(( j+1 ))
      cd ..
  fi
done
