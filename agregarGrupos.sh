#!/bin/bash
ROOT_UID=0
SUCCESS=0

welcome_message(){
	clear
	echo -e "\e[31m -BBBBBBBB       BBBBBB  BBBBBBBBBB  BB      BB  BB      BB  BBBBBBBBBB  BB      BB  BBBBBB  BBBBBBBB      BBBBBB  -\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BB      BB  BB      BB  BB          BB      BB    BB    BB      BB  BB      BB-\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BBBB    BB  BB      BB  BB          BBBB    BB    BB    BB      BB  BB      BB-\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BBBB    BB  BB      BB  BB          BBBB    BB    BB    BB      BB  BB      BB-    .--.\e[0m"
	echo -e "\e[31m -BBBBBBBB         BB    BBBBBBBB    BB  BB  BB  BB      BB  BBBBBBBB    BB  BB  BB    BB    BB      BB  BB      BB-   |o_o |\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BB    BBBB  BB      BB  BB          BB    BBBB    BB    BB      BB  BB      BB-   |:_/ |\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BB    BBBB  BB      BB  BB          BB    BBBB    BB    BB      BB  BB      BB-  //   \ \'\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BB      BB  BB      BB  BB          BB      BB    BB    BB      BB  BB      BB- (| JGP | )'\e[0m"
	echo -e "\e[31m -BB       BB      BB    BB          BB      BB    BB  BB    BB          BB      BB    BB    BB      BB  BB      BB-/'\_   _/'\'\e[0m"
	echo -e "\e[31m -BBBBBBBBB      BBBBBB  BBBBBBBBBB  BB      BB      BB      BBBBBBBBBB  BB      BB  BBBBBB  BBBBBBBB      BBBBBB  -\___)=(___/'\e[0m"
}

bye_message(){
	echo -e "\e[31m \t\t\t\t\t-BBBBBBBB     BB      BB  BBBBBBBBBB-\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB  BB      BB  BB        -\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB  BB      BB  BB        -\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB  BB      BB  BB        -    .--.\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BBBBBBBB     BB      BB  BBBBBBBB  -   |o_o |\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB    BB  BB    BB        -   |:_/ |\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB      BB      BB        -  //   \ \'\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB      BB      BB        - (| JGP | )'\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BB       BB      BB      BB        -/'\_   _/'\'\e[0m"
	echo -e "\e[31m \t\t\t\t\t-BBBBBBBBB        BB      BBBBBBBBBB-\___)=(___/'\e[0m"	
}
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Ejecute como root este script"
  echo "Format-> sudo ./name_file groups.csv"
  exit $E_NOTROOT
fi  

file=$1

if [ "${file}X" = "X" ];
then
   echo "Debe pasar como parametro groups.csv"
   echo "Format-> sudo ./name_file groups.csv"
   exit 1
fi


crearGrupo(){
	#echo "----> Crear Grupo <----"
	eval nombreGrupo="$1"
	#echo "nombreGrupo 		  = ${nombreGrupo}"
	#echo "-------------------------"
	
	#-p, --password PASSWORD
    #Note: This option is not recommended because the password (or encrypted password) will be visible by users listing the processes.
    #You should make sure the password respects the system's password policy.
	groupadd "${nombreGrupo}"
	if [ $? -eq $SUCCESS ];
	then
		echo -e "\e[31m \t\t\t\tGrupo [${nombreGrupo}] agregado correctamente..."
	else
		echo -e "\e[31m \t\t\t\tGrupo [${nombreGrupo}] No se pudo agregar..."
	fi
}
	welcome_message
	sleep 3s
while IFS=: read -r f1
do
	crearGrupo "\${f1}"	
	sleep 2s
done < ${file}
 bye_message
 sleep 5s
exit 0