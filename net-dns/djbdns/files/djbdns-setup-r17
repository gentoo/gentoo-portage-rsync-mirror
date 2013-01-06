#!/bin/bash
#
# djbdns-setup
#
# Copyright (C) 2004-2006 Kalin KOZHUHAROV <kalin@thinrope.net>
# The latest version of this script can be accessed at:
# rsync://rsync.tar.bz/gentoo-portage-pkalin/net-dns/djbdns/files/djbdns-setup
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# http://www.gnu.org/copyleft/gpl.html
#

# {{{ Rip off the ewarn code from /sbin/functions.sh
WARN=$'\e[33;01m'
NORMAL=$'\e[0m'
ewarn() {
	echo -e " ${WARN}*${NORMAL} $*"
	return 0
}
# }}}

# {{{ global vars
S_SEPARATOR="--------------------------------------------------------------------------------"
D_SEPARATOR="================================================================================"

REQ_GROUP="nofiles"
REQ_USERS="tinydns dnscache dnslog"

IPs[0]=""
IPs[1]=""
IPs[2]=""
dnscache=0
tinydns=1
axfrdns=2

# global vars }}}

# {{{ functions
check_group_users()
{
	echo ": Checking for required group (${REQ_GROUP}) :"
	grep ${REQ_GROUP} /etc/group &> /dev/null
	if [ $? -ne 0 ]
	then
	ebegin "Adding group ${REQ_GROUP}"
	/usr/sbin/groupadd ${REQ_GROUP} &>/dev/null && eend 0 || eend 1
	fi

	echo ": Checking for required users (${REQ_USERS}) :"
	for user in ${REQ_USERS};
	do
	grep ${user} /etc/passwd &> /dev/null
	if [ $? -ne 0 ]
	then
		ebegin "Adding user ${user}"
		/usr/sbin/useradd -d /dev/null -s /bin/false -g ${REQ_GROUP} ${user} &>/dev/null && eend 0 || eend 1
	fi
	done
	return 0
}

start_services()
{
	local services="$1"

	echo "${SEPARATOR}"
	echo ": Start services :"
	echo
	echo "   Your services (${services// /, }) are ready for startup!"
	echo
	ewarn "   The following requires daemontools to be running!"
	local answer=""
	read -p "   Would you like ${services// /, } to be started and supervised by daemontools now? [Y|n]> " answer
	if [ "${answer}" == "Y" ] || [ "${answer}" == "" ]
	then

	ebegin "Checking if daemontools are running"
	ps -A |grep svscanboot &>/dev/null && eend 0 || eend 1

	ebegin "Linking services in /service"
	# Don't make symbolic links to / !
	# use ../ instead as it gives trouble in chrooted environments
	local fixedroot_path=`echo ${mypath} | sed -e 's#^/#../#'`
	for service in ${services};
	do
		for ip in ${IPs[${service}]};
		do
		ln -sf ${fixedroot_path}/${service}/${ip} /service/${service}_${ip}
		done
	done

	eend 0

	echo
	ls -l --color=auto /service/
	echo
	ebegin "Waiting 5 seconds for services to start"
	sleep 5 && eend 0

	echo "${SEPARATOR}"
	echo ": Check services status :"
	echo
	for service in ${services};
	do
		for ip in ${IPs[${service}]};
		do
		svstat /service/${service}_${ip} /service/${service}_${ip}/log
		done
	done
	fi
	return 0
}

tinydns_setup()
{
	return 0
}

axfrdns_setup()
{
	echo "${S_SEPARATOR}"
	echo ": Grant access to axfrdns :"
	echo
	TCPRULES_DIR="${mypath}/axfrdns/${myip}/control"
	echo "   axfrdns is accessed by your secondary servers and when response cannot fit UDP packet"
	echo "   You have to specify which IP addresses are allowed to access it"
	echo "   in ${TCPRULES_DIR}/tcp.axfrdns"
	echo
	echo "   Example:"
	echo "     1.2.3.4 would allow the host 1.2.3.4"
	echo "     1.2.3.  would allow ALL hosts 1.2.3.x (like 1.2.3.4, 1.2.3.100, etc.)"
	ewarn "Do NOT forget the trailing dot!"
	echo
	echo "   Press Enter if you do not want to allow any access now."
	echo

	sed -i -e "s#-x tcp.cdb#-x control/tcp.axfrdns.cdb#g" ${mypath}/axfrdns/${myip}/run
	if [ -e ${TCPRULES_DIR}/tcp.axfrdns ]
	then
		ewarn "${TCPRULES_DIR}/tcp.axfrdns exists."
		read -p "   Do you want it cleared? [y|N]: " answer
		if [ "${answer}" == "y" ]
		then
		echo '# sample line:  1.2.3.4:allow,AXFR="heaven.af.mil/3.2.1.in-addr.arpa"' > ${TCPRULES_DIR}/tcp.axfrdns
		fi
	fi

	read -p "   IP to allow (press Enter to end)> " ipallow

	while [ "$ipallow" != "" ]
	do
		echo "${ipallow}:allow" >> ${TCPRULES_DIR}/tcp.axfrdns
		read -p "   IP to allow (press Enter to end)> " ipallow
	done
	echo ":deny" >> ${TCPRULES_DIR}/tcp.axfrdns

	echo "   Here are the tcprules created so far:"
	echo
	cat ${TCPRULES_DIR}/tcp.axfrdns
	echo
	local answer=""
	read -p "   Would you like ${TCPRULES_DIR}/tcp.axfrdns.cdb updated? [Y|n]: " answer
	if [ "${answer}" == "Y" ] || [ "${answer}" == "" ]
	then
		ebegin "Updating ${TCPRULES_DIR}/tcp.axfrdns.cdb"
		bash -c "cd ${TCPRULES_DIR} && make" && eend 0 || eend 1
	fi
	return 0
}

dnscache_setup()
{
	echo ": Configure forwarding :"
	echo
	echo "   dnscache can be configured to forward queries to another"
	echo "   DNS cache (such as the one your ISP provides) rather than"
	echo "   performing the lookups itself."
	echo
	echo "   To enable this forwarding-only mode (usually a good idea),"
	echo "   provide the IPs of the caches to forward to."
	echo "   To have dnscache perform the lookups itself, just press Enter."
	echo
	read -p "   forward-to IP> " myforward
	echo
	if [ "$myforward" != "" ]
	then
		echo $myforward > ${mypath}/dnscache/${myip}/root/servers/\@
		echo -n "1" > ${mypath}/dnscache/${myip}/env/FORWARDONLY

		read -p "   forward-to IP (press Enter to end)> " myforward
		while [ "$myforward" != "" ]
		do
		echo $myforward >> ${mypath}/dnscache/${myip}/root/servers/\@
		read -p "   forward-to IP (press Enter to end)> " myforward
		done

		echo
		echo "   Currently all queries will be forwarded to:"
		echo
		cat ${mypath}/dnscache/${myip}/root/servers/\@
		echo
	fi

	echo "${SEPARATOR}"
	echo ": Configuring clients :"
	echo
	echo "   By default dnscache allows only localhost (127.0.0.1) to"
	echo "   access it. You have to specify the IP addresses of the"
	echo "   clients that shall be allowed to use it."
	echo
	echo "   Example:"
	echo "      1.2.3.4 would allow only one host: 1.2.3.4"
	echo "      1.2.3   would allow all hosts 1.2.3.0/24 (e.g. 1.2.3.4, 1.2.3.100, etc.)"
	echo
	echo "   Press Enter if you do NOT want to allow external clients!"
	echo

	read -p "   Allowed IP> " myclientip

	while [ "$myclientip" != "" ]
	do
		touch ${mypath}/dnscache/${myip}/root/ip/${myclientip}
		read -p "   Allowed IP (press Enter to end)> " myclientip
	done

	echo
	echo "   All queries from the hosts below will be answered:"
	echo
	ls -1 ${mypath}/dnscache/${myip}/root/ip
	echo
	
	#TODO
	#configure cachsize - $mypath/env/CACHESIZE

	#TODO
	#configure datalimit - $mypath/env/DATALIMIT
	return 0
}

common_setup()
{
	local service_human="$1"
	local service_machine="$2"
	local services="$3"

	echo ": ${service_human} setup :"
	echo

	for service in ${services};
	do
	if [ ! -e ${mypath}/${service} ]
	then
		ebegin "Creating ${mypath}/${service}"
		mkdir -p $mypath/${service} && eend 0 || eend 1
	fi
	done

	echo "${SEPARATOR}"
	echo ": IP address to bind to :"
	echo
	echo "   Specify an address to which the ${service_human} should bind."
	echo "   Currently accessible IPs:"
	local addrs=`ifconfig -a | grep "inet addr" | cut -f2 -d":" | cut -f1 -d" "`
	echo "     "$addrs
	echo

	while [ "${myip}" == "" ]
	do
	read -p "   IP to bind to> " myip
	done
	echo

	for service in ${services};
	do
	IPs[${service}]="${IPs[${service}]} ${myip}"
	done

	local dnscache_INSTALL="/usr/bin/dnscache-conf dnscache dnslog ${mypath}/dnscache/${myip} $myip"
	local tinydns_INSTALL="/usr/bin/tinydns-conf tinydns dnslog ${mypath}/tinydns/${myip} $myip"
	local axfrdns_INSTALL="\
	/usr/bin/axfrdns-conf tinydns dnslog ${mypath}/axfrdns/${myip} ${mypath}/tinydns/${myip} $myip &&\
	mkdir -p ${mypath}/axfrdns/${myip}/control &&\
	echo -e \"tcp.axfrdns.cdb:\ttcp.axfrdns\n\ttcprules tcp.axfrdns.cdb .tcp.axfrdns.cdb.tmp < tcp.axfrdns\" > ${mypath}/axfrdns/${myip}/control/Makefile &&\
	rm -f ${mypath}/axfrdns/${myip}/tcp ${mypath}/axfrdns/${myip}/Makefile"

	for service in ${services};
	do
	if [ ! -e ${mypath}/${service}/${myip} ]
	then
		ebegin "Setting up ${service} in ${mypath}/${service}/${myip}"
		eval command=\$${service}_INSTALL
		/bin/bash -c "${command}" && eend 0 || eend 1
	else
		ewarn "${service} directory ${mypath}/${service}/${myip} exists, nothing done."
	fi
	done

}

# functions }}}

# {{{ main script

if [ `id -u` -ne 0 ]
then
	ewarn "You must be root to run this script, sorry."
	exit 1
else

	echo "${D_SEPARATOR}"
	echo ": DJB DNS setup :"
	echo
	echo "   This script will help you setup the following:"
	echo
	echo "     DNS server(s): to publish addresses of Internet hosts"
	echo
	echo "     DNS cache(s) : to  find   addresses of Internet hosts"
	echo
	echo "   For further information see:"
	echo "     http://cr.yp.to/djbdns/blurb/overview.html"
	echo
	ewarn "If you have already setup your services,"
	ewarn "either exit now, or setup in different directories."
	echo

	answer=""
	read -p "   Would you like to continue with setup? [Y|n]> " answer
	if [ "${answer}" == "n" ] || [ "${answer}" == "N" ]
	then
	ewarn "Aborting setup"
	exit 1
	fi

	echo "${D_SEPARATOR}"
	echo ": Choose install location :"
	echo
	default_path="/var"
	echo "   The default (${default_path}) will install them"
	echo "     in ${default_path}/\${service}/\${IP_ADDRESS}"
	echo
	echo " For example:"
	echo "     /var/tinydns /1.2.3.4"
	echo "                  /192.168.33.1"
	echo "         /axfrdns /1.2.3.4"
	echo "                  /192.168.33.1"
	echo "         /dnscache/127.0.0.1"
	echo
	ewarn "Do NOT enter trailing slash"
	echo "   Where do you want services installed?"
	read -p "[${default_path}] > " mypath
	echo

	if [ "${mypath}" == "" ]
	then
	mypath=${default_path}
	fi

	echo "${D_SEPARATOR}"
	check_group_users

	answer=""
	another=""
	until [ "$answer" == "n" ]
	do
	echo "${D_SEPARATOR}"
	answer=""
	read -p "   Would you like to setup ${another}dnscache? [Y|n]> " answer
	if [ "${answer}" == "Y" ] || [ "${answer}" == "" ]
	then
		myip=""
		echo "${S_SEPARATOR}"
		common_setup "DNS cache" "dnscache" "dnscache"
		if [ $? == 0 ]
		then
		dnscache_setup
		else
		ewarn "Skipping dnscache specific setup."
		fi
	fi
	another="another "
	done

	answer=""
	another=""
	until [ "$answer" == "n" ]
	do
	echo "${D_SEPARATOR}"
	answer=""
	read -p "   Would you like to setup ${another}DNS server? [Y|n]> " answer
	if [ "${answer}" == "Y" ] || [ "${answer}" == "" ]
	then
		myip=""
		echo "${S_SEPARATOR}"
		common_setup "DNS server" "{tinydns,afxrdns}" "tinydns axfrdns"
		if [ $? == 0 ]
		then
		tinydns_setup
		axfrdns_setup
		else
		ewarn "Skipping tinydns and axfrdns specific setup."
		fi
	fi
	another="another "
	done

	echo "${D_SEPARATOR}"
  
	start_services "tinydns axfrdns dnscache"
	
	echo "${D_SEPARATOR}"
fi
# main script }}}
# vim: set ts=4 fenc=utf-8 foldmethod=marker:
