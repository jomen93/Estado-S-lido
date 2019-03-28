echo "Si quiere variar a para encontrar el valor"
echo "de la estructura estable [s]/[n]"
read cond
if [[ $cond = "s" ]]; then
  #statements

  x=(2.00        2.12080537  2.24161074  2.36241611  2.48322148
        2.60402685  2.72483221  2.84563758  2.96644295  3.08724832
        3.20805369  3.32885906  3.44966443  3.5704698   3.69127517
        3.81208054  3.93288591  4.05369128  4.17449664  4.29530201
        4.41610738  4.53691275  4.65771812  4.77852349  4.89932886
        5.02013423  5.1409396   5.26174497  5.38255034  5.5033557 
        5.62416107  5.74496644  5.86577181  5.98657718  6.10738255
        6.22818792  6.34899329  6.46979866  6.59060403  6.7114094 
        6.83221477  6.95302013  7.0738255   7.19463087  7.31543624
        7.43624161  7.55704698  7.67785235  7.79865772  7.91946309
        8.04026846  8.16107383  8.28187919  8.40268456  8.52348993
        8.6442953   8.76510067  8.88590604  9.00671141  9.12751678
        9.24832215  9.36912752  9.48993289  9.61073826  9.73154362
        9.85234899  9.97315436 10.09395973 10.2147651  10.33557047
       10.45637584 10.57718121 10.69798658 10.81879195 10.93959732
       11.06040268 11.18120805 11.30201342 11.42281879 11.54362416
       11.66442953 11.7852349  11.90604027 12.02684564 12.14765101
       12.26845638 12.38926174 12.51006711 12.63087248 12.75167785
       12.87248322 12.99328859 13.11409396 13.23489933 13.3557047 
       13.47651007 13.59731544 13.71812081 13.83892617 13.95973154
       14.08053691 14.20134228 14.32214765 14.44295302 14.56375839
       14.68456376 14.80536913 14.9261745  15.04697987 15.16778523
       15.2885906  15.40939597 15.53020134 15.65100671 15.77181208
       15.89261745 16.01342282 16.13422819 16.25503356 16.37583893
       16.4966443  16.61744966 16.73825503 16.8590604  16.97986577
       17.10067114 17.22147651 17.34228188 17.46308725 17.58389262
       17.70469799 17.82550336 17.94630872 18.06711409 18.18791946
       18.30872483 18.4295302  18.55033557 18.67114094 18.79194631
       18.91275168 19.03355705 19.15436242 19.27516779 19.39597315
       19.51677852 19.63758389 19.75838926 19.87919463 20.00)

  for i in {0..148}
  do 
	 echo "Se esta calculando ", ${x[$i+1]}
	 sed -i.bak "s/${x[$i]}/${x[$i+1]}/g" ./diamond.fdf
	 ../siesta-4.1-b2/Obj/siesta < diamond.fdf > diamond_${x[$i+1]}_.dat 
  done

  grep "Total = " diamond_*_.dat > diamond.dat

  #sed -i.bak "s/${x[148]}/${x[0]}/g"

  name1=Datos
  name2=fdf.log
  name3=INPUT

  if [ ! -e "${name1}" ]; then
    mkdir "${name1}"
    echo "No existe la carpeta ${name1}, se crea y se mandan los archivos correspondientes"
    mv diamond_*_.dat "${name1}"
    sleep 1
    clear
  else 
    rm "${name1}"/diamond_*_.txt
    echo "Se borran los elementos antiguos en ${name1} y se mandan archivos correspondientes"
    mv diamond_*_.dat "${name1}"
    sleep 1
    clear
  fi

  if [ ! -e "${name2}" ]; then
    mkdir "${name2}"
    echo "No existe la carpeta ${name2}, se crea y se mandan los archivos correspondientes"
    mv fdf-*.log "${name2}"
    sleep 1
    clear
  else 
    rm "${name2}"/diamond_*_.txt
    echo "Se borran los elementos antiguos en ${name2} y se mandan archivos correspondientes"
    mv fdf-*.log "${name2}"
    sleep 1
    clear
  fi

  if [ ! -e "${name3}" ]; then
    mkdir "${name1}"
    echo "No existe la carpeta ${name3}, se crea y se mandan los archivos correspondientes"
    mv INPUT_TMP* "${name3}"
    sleep 1
    clear
  else 
    rm "${name3}"/diamond_*_.txt
    echo "Se borran los elementos antiguos en ${name3} y se mandan archivos correspondientes"
    mv INPUT_TMP* "${name3}"
    sleep 1
    clear
  fi

fi

echo "Calculamos densidad de carga bulk Diamante"
echo "El valor encontrado fue"
echo "------- a = 3.570469799459459"
sed -i.bak "s/20.00/3.570469799459459/g" ./diamond.fdf
../siesta-4.1-b2/Obj/siesta < diamond.fdf > diamond_a.dat 

# python cube.py -f C.RHO.cube -o nombre.dat -x 5 -pl -A
#./denchar < diamond.fdf
#../siesta-4.1-b2/Util/Vibra/Src/vibra < diamond.fcbuild.fdf
#../siesta-4.1-b2/Util/Bands/gnubands < C.bands > diamond.bands.dat

