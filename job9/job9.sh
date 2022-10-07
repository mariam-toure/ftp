#!/bin/bash
cd /home/hajar/Dawnlaods
cat userlist.csv | while read varligne
do
	password=`echo $varligne |cut -d ',' -f4`
	username=`echo $varligne |cut -d ',' -f2`
	username=`echo ${username,,}`
	role=`echo $varligne |cut -d ',' -f5`
	echo $role
	if [ ${role:0:5} = "Admin" ]
	then
		# création des utilisateurs avec la variable username
		echo "creation de l'utilisateur : $username"
        	
        	#sudo useradd -m -p /home/$username $username
		#utlisation de perl pour cryptage de mot de passe 
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password) 
		useradd -m -p "$pass" "$username"
      		echo "changement du role de : $username"
      		
      		#élévation de groupe admin au mode sudo  
     		sudo usermod -aG sudo $username
        	
        	# création de groupe 
        	sudo groupadd ftp_group
        	
        	# ajout des utilsateurs au groupe         	
        	sudo adduser $username ftp_group
        	#echo $username:$password | chpasswd
    	else 
       	 	echo "creation de l'utilisateur : $username"
        	#sudo useradd -m -p /home/$username $username
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)       
        	sudo useradd -m -p "$pass" "$username"
        	#echo "$username:$password" | chpasswd     

    fi
done < <(tail -n +2 userlist.csv)
