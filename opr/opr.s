declare -a aa
declare -a out0
declare count
declare count2
declare pagefault=3
declare topval
declare array=0
declare c=1
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
     for i1 in `seq 0 2`
     do
       out0[i1]=${aa[i1]}
     done
}
ans()
{
    for i2 in `seq 3 $count2`
    do
     a=0
     s="out"$array
     s1="out"$array[1]
     s2="out"$array[2]
     #echo ${!s}
     #echo ${!s1}
     #echo ${!s2}
     mn=${!s}
     mn1=${!s1}
     mn2=${!s2}
     topval[array]=${aa[$i2]}
     if [ ${aa[i2]} -eq ${!s} ]
     then
      a=1
     elif [ ${aa[i2]} -eq ${!s1} ]
     then
      a=1
     elif [ ${aa[i2]} -eq ${!s2} ]
     then
      a=1
     else
      a=0
      fi
      if [ $a -eq 0 ]
      then
      pagefault=`expr $pagefault + 1`
     check $mn `expr $i2 + 1` 
     check1 $mn1 `expr $i2 + 1`
     check2 $mn2 `expr $i2 + 1` 
     add $mn $mn1 $mn2 ${aa[$i2]}
     c=`expr $c + 1`
     array=`expr $array + 1`
     else
        next=out$c
        eval "$next=( $mn $mn1 $mn2 )"
        c=`expr $c + 1`
        array=`expr $array + 1`
     fi

    done
}
check()
{
    ch=$1
    first=0
    
    for i3 in `seq $2 $count2`
    do
      if [ $ch -eq ${aa[$i3]} ]
      then
      
      first=$i3
      break
      fi
    done
}
check1()
{
    ch=$1
    second=0
    for i4 in `seq $2 $count2`
    do
      if [ $ch -eq ${aa[$i4]} ]
      then
      second=$i4
      break
      fi
    done
}
check2()
{
    ch=$1
    third=0
    for i5 in `seq $2 $count2`
    do
      if [ $ch -eq ${aa[$i5]} ]
      then
      third=$i5
    break
      fi
    done
}
add()
{
    #echo "f="$first
    #echo "s="$second
    #echo "t="$third
    next=out$c
    if [ $first -eq 0 ] && [ $second -eq 0 ] && [ $third -eq 0 ]
   then
      threezero 0 1 2 $array
      if [ $add1 -eq 0 ] && [ $add2 -eq 0 ] && [ $add3 -eq 0 ]
      then
      eval "$next=( $4 $2 $3 )"
      elif [ $add1 -gt $add2 ] && [ $add1 -gt $add3 ]
      then
      eval "$next=( $4 $2 $3 )"
      elif [ $add2 -gt $add1 ] && [ $add2 -gt $add3 ]
      then
      eval "$next=( $1 $4 $3 )"
      else
      eval "$next=( $1 $2 $4 )"
      fi
   elif [ $first -eq 0 ] && [ $second -ne 0 ] && [ $third -ne 0 ]
   then
   eval "$next=( $4 $2 $3 )"
   elif [ $second -eq 0 ] && [ $first -ne 0 ] && [ $third -ne 0 ]
   then
   eval "$next=( $1 $4 $3 )"
   elif [ $third -eq 0 ] && [ $first -ne 0 ] && [ $second -ne 0 ]
   then
   eval "$next=( $1 $2 $4 )"
   elif [ $first -eq 0 ] && [ $second -eq 0 ]
   then
   twozero 0 1 $array
     if [ $add1 -gt $add2 ] || [ $add1 -eq $add2 ]
     then
     eval "$next=( $4 $2 $3 )"
     else
      eval "$next=( $1 $4 $3 )"
     fi
   elif [ $first -eq 0 ] && [ $third -eq 0 ]
   then
   twozero 0 2 $array
     if [ $add1 -gt $add2 ] || [ $add1 -eq $add2 ]
     then
     eval "$next=( $4 $2 $3 )"
     else
     eval "$next=( $1 $2 $4 )"
     fi
   elif [ $second -eq 0 ] && [ $third -eq 0 ]
   then
   twozero 1 2 $array
     if [ $add1 -gt $add2 ] || [ $add1 -eq $add2 ]
     then
     eval "$next=( $1 $4 $3 )"
     else
     eval "$next=( $1 $2 $4 )"
     fi
   else
    if [ $first -gt $second ] && [ $first -gt $third ]
    then
    eval "$next=( $4 $2 $3 )"
    elif [ $second -gt $first ] && [ $second -gt $third ]
    then
    eval "$next=( $1 $4 $3 )"
    else
    eval "$next=( $1 $2 $4 )"
    fi
   fi
}
twozero()
{
    mat=out$array[$1]
    match=${!mat}
    mat1=out$array[$2]
    match1=${!mat1}
    cd=`expr $3 - 1`
    add1=0
    add2=0
    for i in `seq 0 $cd`
    do
      nn=out$i[$1]
      if [ ${!nn} -eq $match ]
      then
      add1=`expr add1 + 1`
       fi
    done
    for i2 in `seq 0 $cd`
    do
    nj=out$i2[$2]
    if [ ${!nj} -eq $match1 ]
    then
    add2=`expr add2 + 1`
    fi
    done
    echo "a="$add1
    echo "b="$add2
}
threezero()
{
    #echo "threezeromatch="
    mat=out$array[$1]
    match=${!mat}
    mat1=out$array[$2]
    match1=${!mat1}
    mat2=out$array[$3]
    match2=${!mat2}
    cd=`expr $4 - 1`
    add1=0
    add2=0
    add3=0
    for i in `seq 0 $cd`
    do
      nn=out$i[$1]
      if [ ${!nn} -eq $match ]
      then
      add1=`expr $add1 + 1`
       fi
    done
    for i2 in `seq 0 $cd`
    do
    nj=out$i2[$2]
    if [ ${!nj} -eq $match1 ]
    then
    add2=`expr $add2 + 1`
    fi
    done
    for i3 in `seq 0 $cd`
    do
    nj1=out$i3[$3]
    if [ ${!nj1} -eq $match2 ]
    then
    add3=`expr $add3 + 1`
    fi
    done
    #echo "a="$add1
    #echo "a2="$add2
    #echo "a3="$add3
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
  echo -e "f(3) means first three values\n"
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