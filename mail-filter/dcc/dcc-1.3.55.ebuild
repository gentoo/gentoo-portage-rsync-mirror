# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dcc/dcc-1.3.55.ebuild,v 1.11 2009/09/23 17:52:47 patrick Exp $

inherit flag-o-matic

DESCRIPTION="Distributed Checksum Clearinghouse"
HOMEPAGE="http://www.rhyolite.com/anti-spam/dcc/"
MY_P="dcc-dccd-${PV}"
SRC_URI="http://www.rhyolite.com/anti-spam/dcc/source/${MY_P}.tar.Z"

LICENSE="DCC"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="ipv6 rrdtool"

RDEPEND="dev-lang/perl
	rrdtool? ( net-analyzer/rrdtool )
	|| ( net-misc/wget www-client/fetch net-misc/curl net-ftp/ftp )"
DEPEND="sys-apps/sed
	sys-devel/gcc
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

dcc_cgibin=/var/www/localhost/cgi-bin/dcc
dcc_homedir=/var/dcc
dcc_libexec=/usr/sbin
dcc_man=/usr/share/man
dcc_rundir=/var/run/dcc

src_compile() {
	sed -i -e "s:^RRDTOOL=/usr/local/bin/rrdtool:RRDTOOL=/usr/bin/rrdtool:" \
		misc/dcc-stats-init.in
	sed -i -e "s:^RRDTOOL=/usr/local/bin/rrdtool:RRDTOOL=/usr/bin/rrdtool:" \
		misc/dcc-stats-graph.in
	sed -i -e "s:^RRDTOOL=/usr/local/bin/rrdtool:RRDTOOL=/usr/bin/rrdtool:" \
		misc/dcc-stats-collect.in
	sed -i -e "s:@installroot@:${D}:" \
		cgi-bin/Makefile.in

	local myconf
	myconf="${myconf} --homedir=${dcc_homedir}"
	myconf="${myconf} --libexecdir=${dcc_libexec}"
	myconf="${myconf} --bindir=/usr/bin"
	myconf="${myconf} --mandir=/usr/share/man"
	myconf="${myconf} --with-cgibin=${dcc_cgibin}"
	myconf="${myconf} --disable-dccm"
	#myconf="${myconf} --without-cgibin"
	myconf="${myconf} --with-rundir=/var/run/dcc"
	myconf="${myconf} `use_enable ipv6 IPv6`"
	./configure ${myconf} || die "configure failed!"
	#make -C homedir
	emake || die "emake failed!"
}

moveconf() {
	for i in $@; do
		local into=/etc/dcc/
		local from=/var/dcc/
		mv ${D}${from}${i} ${D}${into}
		dosym ${into}${i} ${from}${i}
	done
}

src_install() {
	# stolen from the RPM .spec and modified for gentoo
	MANOWN=root MANGRP=root export MANOWN MANGRP
	BINOWN=$MANOWN BINGRP=$MANGRP export BINOWN BINGRP
	DCC_PROTO_HOMEDIR=${D}${dcc_homedir} export DCC_PROTO_HOMEDIR
	DCC_CGIBINDIR=${D}${dcc_cgibin} export DCC_CGIBINDIR
	DCC_SUID=$BINOWN DCC_OWN=$BINOWN DCC_GRP=$BINGRP export DCC_SUID DCC_OWN DCC_GRP

	dodir /etc/cron.daily ${dcc_homedir} ${dcc_cgibin} /usr/bin /usr/sbin /usr/share/man/man{0,8} /etc/dcc
	keepdir /var/run/dcc /var/log/dcc

	make DESTDIR=${D} DCC_BINDIR=${D}/usr/bin MANDIR=${D}/usr/share/man/man DCC_HOMEDIR=${D}${dcc_homedir} install || die

	einfo "Branding and setting reasonable defaults"
	sed -e "s/BRAND=\$/BRAND='Gentoo ${PF}'/;" \
		-e "s/DCCM_LOG_AT=5\$/DCCM_LOG_AT=50/;" \
		-e "s,DCCM_LOGDIR=log\$,DCCM_LOGDIR=/var/log/dcc,;" \
		-e "s/DCCM_ARGS=\$/DCCM_ARGS='-SHELO -Smail_host -SSender -SList-ID'/;" \
		-e "s/DCCIFD_ARGS=\$/DCCIFD_ARGS=\"\$DCCM_ARGS\"/;" \
		-e 's/DCCIFD_ENABLE=off/DCCIFD_ENABLE=on/' \
		-i ${D}${dcc_homedir}/dcc_conf

	einfo "Providing cronjob"
	mv ${D}/usr/bin/cron-dccd ${D}/etc/cron.daily/dccd

	einfo "Putting system code in sbin instead of bin"
	mv ${D}/usr/bin/{dbclean,dblist,dccd,dccsight,start-dccd,stop-dccd,wlist,newwebuser,stats-get,dccifd,start-grey,start-dccifd,fetch-testmsg-whitelist} ${D}/usr/sbin/ || die "Failed to move apps to sbin"

	statslist="${D}/usr/bin/{dcc-stats-graph,dcc-stats-init,dcc-stats-collect}"
	if use rrdtool; then
		einfo "Installing rrdtool interface scripts"
		eval mv $statslist ${D}/usr/sbin/ || die "Failed to move rrdtool apps"
	else
		einfo "Removing rrdtool interface scripts"
		eval rm -f ${statslist} || die "Failed to clean up rrdtool scripts"
	fi

	einfo "Cleaning up"
	rm -f ${D}/usr/bin/{logger,hackmc,na-spam,ng-spam,rcDCC,start-dccm,updatedcc,dns-helper}

	einfo "Placing configuration files into /etc instead of /var/run"
	moveconf dcc_conf flod grey_flod grey_whitelist ids map.txt whiteclnt whitecommon whitelist

	rmdir ${D}/var/dcc/log/
}
