#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/mail-mta/netqmail/files/qmail-genrsacert.sh,v 1.2 2006/05/06 20:15:11 hansmi Exp $
# Robin H. Johnson <robbat2@gentoo.org> - October 17, 2003
#
# This file generates the static temporary RSA keys needed for qmail to encrypt
# messages. It should be run from a crontab, once a day is ok on low load
# machines, but if you do lots of mail, once per hour is more reasonable if you
# do NOT create the rsa512.pem, qmail will generate it on the fly for each
# connection, which can be VERY slow.

confdir=${ROOT}/var/qmail/control

# the key should be 0600
# which is readable by qmaild only!
umaskvalue="0077"
uid="qmaild"
gid="qmail"

umask ${umaskvalue}

# If you want to renice this process, uncomment the following line:
# renice +15 "$$" >/dev/null

# This is a list with bits of the generated keys. They should
# be a power of 2 ideally and must be more than 64.
keys="512 1024"

for bits in ${keys}
do
	pemfile="${confdir}/rsa${bits}.pem"
	tmpfile="${confdir}/rsa${bits}.pem.tmp"

	# we need to make sure that all of the operations succeed
	/usr/bin/openssl genrsa -out ${tmpfile} ${bits} 2>/dev/null && \
	/bin/chown ${uid}:${gid} ${tmpfile} && \
	/bin/mv -f ${tmpfile} ${pemfile} || exit 1

	dhfile="${confdir}/dh${bits}.pem"
	dtmpfile="${confdir}/dh${bits}.pem.tmp"

	/usr/bin/openssl dhparam -2 -out ${dtmpfile} ${bits} 2>/dev/null && \
	/bin/chown ${uid}:${gid} ${dtmpfile} && \
	/bin/mv -f ${dtmpfile} ${dhfile} || exit 1
done
