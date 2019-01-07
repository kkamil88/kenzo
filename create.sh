#!/bin/bash
shopt -s expand_aliases
#-----------------------------------------------------------------------------------------------
#init engine root

project='kenzo'
domain='kenaz.in'
url='http://'$project'.'$domain
password='1Nowehaslo'$project
login=$project
email='admin@'$domain
db="kenaz_"$project
dbname=$db
dbuser=$db
dbpass='6Me$J13^1@G+k&5'

rm -rf ./$project
curl -sS https://getcomposer.org/installer | php
php composer.phar create-project wp-cli/wp-cli $project
mkdir $project/wp
cd $project
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    cd wp
        php ../wp-cli.phar db reset --yes
        php ../wp-cli.phar core download --locale=en_US
        php ../wp-cli.phar core config  --dbname=$dbname --dbuser=$dbuser --dbpass=$dbpass
        php ../wp-cli.phar core install  --url=$url --title=$project --admin_user=$login --admin_password=$password --admin_email=$email
        php ../wp-cli.phar cli update

        mkdir wp-content/plugins/kenzo
        php ../wp-cli.phar plugin delete akismet
        php ../wp-cli.phar plugin delete hello

        acf_zip_file="$(php ../wp-cli.phar plugin path)/acf-pro.zip"
        wget -O ${acf_zip_file} "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9ODI1MTF8dHlwZT1kZXZlbG9wZXJ8ZGF0ZT0yMDE2LTA1LTI4IDA5OjI3OjMw"
        php ../wp-cli.phar plugin install ${acf_zip_file} --activate
        rm ${acf_zip_file}
        php ../wp-cli.phar eval 'acf_pro_update_license("b3JkZXJfaWQ9ODI1MTF8dHlwZT1kZXZlbG9wZXJ8ZGF0ZT0yMDE2LTA1LTI4IDA5OjI3OjMw");'

        mkdir wp-content/themes/default
        php ../wp-cli.phar theme activate default
        php ../wp-cli.phar theme delete twentynineteen
        php ../wp-cli.phar theme delete twentysixteen
        php ../wp-cli.phar theme delete twentyseventeen

#----------------------------------------------------------------------------------------------

printf "\033c"
#php wp-cli.phar --info

#echo "###############################################################"
#ls /wp-content/plugins/ -R  | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
#echo "###############################################################"
#echo "###############################################################"
#echo "###############################################################"
#
#echo "###############################################################"


#----------------------------------------------------------------------------------------------



#----------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------





#
#echo '#########4########################################################################################################'
#echo 'before config:'
#echo '#';
#echo '#';
#php ../wp-cli.phar plugin list
#php ../wp-cli.phar theme list
#echo '#';
#echo '#';
#echo '#################################################################################################################'
#echo 'after config:'
#php ../wp-cli.phar --info
#echo '#'
#echo '#'
#php ../wp-cli.phar plugin list
#php ../wp-cli.phar theme list
#
