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

show_users(){
	count=0
	while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
	do
		count=$(($count + 1))
		echo "|========================Usuario====[$count]=============|"
		echo -e "\t Username: [\e[34m${f1}\e[0m]"
		echo -e "\t password: [\e[34m${f2}\e[0m]"
		echo -e "\t User_ID: [\e[34m${f3}\e[0m]"
		echo -e "\t Group_ID: [\e[34m${f4}\e[0m]"
		echo -e "\t Full_Name: [\e[34m${f5}\e[0m]"
		echo -e "\t ../: [\e[34m${f6}\e[0m]"
		echo -e "\t ../Shell: [\e[34m${f7}\e[0m]"
		echo "|===================================================|"
		sleep 1s
	done < ${file}
}

create_user(){
	useradd -p ${f2} -u ${f3} -g ${f4} -c "${f5}" -m -d ${f6} -s ${f7} ${f1}
	if [ $? -eq $SUCCESS ];
	then
		echo ${f1}:${f2}|chpasswd
		chage -d 0 "${f1}"
		if [ $? -eq $SUCCESS ]; then
			echo "Usuario [${f1}] agregado Exitosamente..."
		fi
	else
		echo "Usuario [${f1}] No se pudo agregar..."
	fi
}

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Ejecute como root este script"
  echo "Format-> sudo ./name_file"
  exit $E_NOTROOT
fi  

file=$1

if [ "${file}X" = "X" ];
then
   echo "Debe pasar como parametro AddUsers.csv"
   echo "Format-> sudo ./name_file AddUsers.csv"
   exit 1
fi

if [ -s "$file" ]; 
then
	echo "OK"	
	sleep 2s
else
	echo "El fichero esta vacio por favor cargue datos con el siguiente formato"
	echo "username:password:id_user:id_group\location->/etc/group:comment||full_name:/home/example:/bin/bash:"
	exit 1
fi
	welcome_message
	echo ""
	sleep 4s
	echo -e "\e[32m \t\tCargando datos de \e[34m$file \e[0m"
	sleep 1s
	echo -e "\e[32m \t\tLISTANDO USUARIOS A INTRODUCIR \e[0m"
	sleep 2s
	show_users
	echo -e "\e[32m \t\tESPERE POR FAVOR... \e[0m"
	sleep 10s
	clear
	welcome_message
	count=0
	while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
	do
		count=$(($count + 1))
		echo "|========================Usuario====[$count]=============|"
		echo -e "\t Username: [\e[34m${f1}\e[0m]"
		echo -e "\t password: [\e[34m${f2}\e[0m]"
		echo -e "\t User_ID: [\e[34m${f3}\e[0m]"
		echo -e "\t Group_ID: [\e[34m${f4}\e[0m]"
		echo -e "\t Full_Name: [\e[34m${f5}\e[0m]"
		echo -e "\t ../: [\e[34m${f6}\e[0m]"
		echo -e "\t ../Shell: [\e[34m${f7}\e[0m]"
		echo "|===================================================|"
		create_user "\${f1}\${f2}\${f3}\${f4}\${f5}\${f6}\${f7} "
	done < ${file}

	echo -e "\e[32m \t\t\tLISTANDO USUARIOS\e[0m"
	count=0
		while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
		do
			getent passwd | grep ${f1}
		done < ${file}

	

bye_message
sleep 3s
exit 0