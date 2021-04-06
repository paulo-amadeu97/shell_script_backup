#!/bin/bash

#########################################################################################
#											#
#	backup_home - este script recebe um usuario e um caminho			#
#	como parâmetro e faz um backup do home do usuario no				#
#	caminho escolhido.								#
#											#
#	Autor: Paulo Amadeu (paulo.amadeu18@gmail.com)					#
#	Data de criação: 07/01/2021							#
#											#
#	para executar este script use: ./backup_home.sh <usuario> <caminho/do/backup>	#
#											#					                      #########################################################################################

USUARIO=$(grep -i $1 /etc/passwd | cut -d":" -f1 )
CAMINHO=$2
DATA=$(date +%Y%m%d%H%M)
if [ $USUARIO -Z ] 2> /dev/null
then
	echo "Usuário invalido"
	echo
	echo "Backup abortado"
	echo "tente backup_home --help para obter ajuda"
	exit 1

	elif [ $1 = "--help" ]
	then
		echo "========== Bem Vindo! ========="
		echo
		echo "backup_home cria um um backup compactado do diretório /home de um usuário especificado."
		echo "backup_home <usuario> <destino do arquivo>"
		echo "backup_home --help - abre esta tela de ajuda."
		echo
		echo "Para mais informações por favor entre em contato com paulo.amadeu18@gmail.com"
fi

ls $CAMINHO > /dev/null 2>&1 || mkdir $CAMINHO

backup () {
	cd $CAMINHO
	tar -czf backup_home_$DATA /home/$USUARIO
	cd -
	echo "Backup $CAMINHO/backup_home_$DATA realizado com sucesso!"
}
if [ $1 != "--help" ]
then
	if ls $CAMINHO/backup_home* > /dev/null 2>&1
	then
		for i in $CAMINHO/backup_home*
		do
			if [ $(expr $(date +%j) - $(date -r $i +%j)) -lt 7 -a $(expr $(date +%j) - $(date -r $i +%j)) -ge 0 ]
			then
				echo "Já existe um arquivo de backup feito a menos 7 dias neste mesmo local"
				read -p "Deseja fazer outro? (S/n)" ESCOLHA
				case $ESCOLHA in
					[Ss])
						echo "Criando backup..."
						echo "Por favor espere."
						backup
						exit 1
						;;
					*)
						echo "Backup abortado."
						exit 1
						;;
				esac
			fi
		done
	fi
fi
echo "Criando backup..."
echo "Por favor espere."
backup
exit 1
