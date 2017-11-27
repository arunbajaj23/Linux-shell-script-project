declare -a aa
declare -a out0
declare count
declare count2
declare array=0
declare b=0
declare c=1
declare topval
declare pagefault=3
declare l=0
user()
{
echo "count the number of values and enter it"
read count
if [ $count -lt 4 ]
then
echo "values is less than 4 byee byee"
exit
fi
count2=`expr $count - 1`
for i in `seq 0 $count2`
do
j=`expr $i + 1`
echo "enter no $j"
read aa[i]  
done
}
valid()
{
if [ $count -gt 3 ]
then
     for i1 in `seq 0 2`
     do
       out0[i1]=${aa[i1]}
     done
    
fi
}
ans()
{
	for i2 in `seq 3 $count2`
	do
	 if [ $b -eq 3 ]
       then
       b=0
      fi
	 s="out"$array
	 s1="out"$array[1]
	 s2="out"$array[2]
	 a=0
	 #echo ${!s}
	 #echo ${!s1}
	 #echo ${!s2}
	 mn=${aa[i2]}
	 topval[array]=$mn
	 if [ $mn -eq ${!s} ]
	 then
	  a=1
	 elif [ $mn -eq ${!s1} ]
	 then
	  a=1
	 elif [ $mn -eq ${!s2} ]
	 then
      a=1
     else
      a=0
      fi
      if [ $a -eq 0 ]
      then
        pagefault=`expr $pagefault + 1`
        next=out$c
        if [ $b -eq 0 ]
        then
        eval "$next=( $mn ${!s1} ${!s2} )"
        elif [ $b -eq 1 ]
        then
        eval "$next=( ${!s} $mn ${!s2} )"
        elif [ $b -eq 2 ]
        then
        eval "$next=( ${!s} ${!s1} $mn)"
        fi 
      c=`expr $c + 1`
      array=`expr $array + 1`
      b=`expr $b + 1`
        #next1=out$c[1]
        #echo ${!next1}
        else
        next=out$c
        eval "$next=( ${!s} ${!s1} ${!s2} )"
        c=`expr $c + 1`
        array=`expr $array + 1`
      fi
      
      
      #echo $c $array $b
   done
}
display()
{
	kk=`expr $c - 1`
echo -ne " f(3)\t"
for i7 in `seq 0 $kk`
do
if [ $i7 -ne $kk ]
then
kg=${topval[$i7]}
if [ $kg -gt 9 ]
then
echo -ne " ($kg)\t"
else
echo -ne "  ($kg)\t"
fi
fi
done
  for i3 in `seq 0 2`
  do
   echo $'\n'
     for  i4 in `seq 0 $kk`
do
     d=out$i4[$i3]
     if [ ${!d} -gt 9 ]
     then
     echo -ne "| ${!d} |\t"
      else
      echo -ne "|  ${!d} |\t"
fi
  done 
done
}
display1()
{
	kk=`expr $c - 1`
  for i3 in `seq 0 $kk`
  do
     d=out$i3
     d1=out$i3[1]
     d2=out$i3[2]
     echo "| ${!d} |"
     echo "| ${!d1} |"
     echo "| ${!d2} |"
     echo "----------------------------"
     if [ $i3 -ne $kk ]
     then
     echo " (${topval[i3]}) "
     fi
  done 
}

pagefault()
{
	echo -e "\n\n pagefault="$pagefault
  echo -e "\nf(3) means first three values\n"
}
user
valid         
ans
echo $'\n output \n \n'
if [ $count -gt 10 ]
then
display1
else
display
fi
pagefault