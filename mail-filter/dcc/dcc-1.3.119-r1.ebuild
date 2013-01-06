# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dcc/dcc-1.3.119-r1.ebuild,v 1.1 2010/07/10 22:18:20 hwoarang Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Distributed Checksum Clearinghouse"
HOMEPAGE="http://www.rhyolite.com/anti-spam/dcc/"
SRC_URI="http://www.rhyolite.com/anti-spam/dcc/source/old/${PN}-${PV}.tar.Z"

LICENSE="DCC"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 rrdtool milter"

RDEPEND="dev-lang/perl
	rrdtool? ( net-analyzer/rrdtool )
	|| ( net-misc/wget www-client/fetch net-misc/curl net-ftp/ftp )
	milter? ( mail-filter/libmilter )"
DEPEND="sys-apps/sed
	sys-devel/gcc
	${RDEPEND}"

dcc_cgibin=/var/www/localhost/cgi-bin/dcc
dcc_homedir=/var/dcc
dcc_libexec=/usr/sbin
dcc_man=/usr/share/man
dcc_rundir=/var/run/dcc

src_unpack() {
	unpack ${A}
	#cd "${S}"
	#epatch "${FILESDIR}"/${PN}-1.3.86.patch
}

src_compile() {
	local myconf
	myconf="${myconf} --homedir=${dcc_homedir}"
	myconf="${myconf} --bindir=/usr/bin"
	myconf="${myconf} --libexecdir=${dcc_libexec}"
	myconf="${myconf} --mandir=/usr/share/man"
	myconf="${myconf} --with-updatedcc_pfile=${dcc_homedir}/updatecc.pfile"
	myconf="${myconf} --with-installroot=${D}"
	myconf="${myconf} --with-DCC-MD5"
	myconf="${myconf} --with-uid=root"
	myconf="${myconf} --enable-server"
	myconf="${myconf} --enable-dccifd"
	#myconf="${myconf} --without-cgibin"
	myconf="${myconf} --with-cgibin=${dcc_cgibin}"
	myconf="${myconf} --with-rundir=${dcc_rundir}"
	myconf="${myconf} --with-db-memory=64"
	myconf="${myconf} --with-max-db-mem=128"
	myconf="${myconf} --with-max-log-size=0"
	myconf="${myconf} $(use_enable ipv6 IPv6)"

	if use milter ; then
		myconf="${myconf} --enable-dccm"
		myconf="${myconf} --with-sendmail="
	else
		myconf="${myconf} --disable-dccm"
	fi

	einfo "Using config: ${myconf}"

	# This is NOT a normal configure script.
	./configure ${myconf} || die "configure failed!"
	#make -C homedir
	emake CC="$(tc-getCC)" || die "emake failed!"
}

moveconf() {
	for i in $@; do
		local into=/etc/dcc/
		mv "${D}"${dcc_homedir}/${i} "${D}"${into}
		dosym ${into}${i} ${dcc_homedir}/${i}
	done
}

src_install() {
	# stolen from the RPM .spec and modified for gentoo
	MANOWN=root MANGRP=root export MANOWN MANGRP
	BINOWN=$MANOWN BINGRP=$MANGRP export BINOWN BINGRP
	DCC_PROTO_HOMEDIR="${D}${dcc_homedir}" export DCC_PROTO_HOMEDIR
	DCC_CGIBINDIR="${D}${dcc_cgibin}" export DCC_CGIBINDIR
	DCC_SUID=$BINOWN DCC_OWN=$BINOWN DCC_GRP=$BINGRP export DCC_SUID DCC_OWN DCC_GRP

	dodir /etc/cron.daily ${dcc_homedir} ${dcc_cgibin} /usr/bin /usr/sbin /usr/share/man/man{0,8} /etc/dcc
	keepdir /var/run/dcc /var/log/dcc

	addwrite "${dcc_homedir}/map"
# This package now takes "${D}" at compile-time!
#	make DESTDIR="${D}" DCC_BINDIR="${D}"/usr/bin MANDIR="${D}"/usr/share/man/man DCC_HOMEDIR="${D}"${dcc_homedir} install || die
	emake install || die

	einfo "Branding and setting reasonable defaults"
	sed -e "s/BRAND=\$/BRAND='Gentoo ${PF}'/;" \
		-e "s/DCCM_LOG_AT=5\$/DCCM_LOG_AT=50/;" \
		-e "s,DCCM_LOGDIR=log\$,DCCM_LOGDIR=/var/log/dcc,;" \
		-e "s/DCCM_ARGS=\$/DCCM_ARGS='-SHELO -Smail_host -SSender -SList-ID'/;" \
		-e "s/DCCIFD_ARGS=\$/DCCIFD_ARGS=\"\$DCCM_ARGS\"/;" \
		-e 's/DCCIFD_ENABLE=off/DCCIFD_ENABLE=on/' \
		-i "${D}"${dcc_homedir}/dcc_conf

	einfo "Enabling milter"
	if use milter ; then
		sed -i -e "s:^[\t #]*\(DCCM_ENABLE[\t ]*=[\t ]*\).*:\1on:g" \
			"${D}"${dcc_homedir}/dcc_conf
	fi

	einfo "Providing cronjob"
	mv "${D}"/usr/sbin/cron-dccd "${D}"/etc/cron.daily/dccd

	einfo "Cleaning up"
	mv "${D}"/usr/sbin/logger "${D}"/usr/sbin/logger-dcc

	statslist="${D}/usr/sbin/{dcc-stats-graph,dcc-stats-init,dcc-stats-collect}"
	if ! use rrdtool; then
		einfo "Removing rrdtool interface scripts"
		eval rm -f ${statslist} || die "Failed to clean up rrdtool scripts"
	fi

	einfo "Cleaning up"
	rm -f "${D}"/usr/sbin/{rcDCC,updatedcc}

	einfo "Placing configuration files into /etc instead of /var/dcc"
	moveconf dcc_conf flod grey_flod grey_whitelist ids map map.txt whiteclnt whitecommon whitelist

	einfo "Install conf.d configuration"
	newconfd "${FILESDIR}"/dcc.confd dcc

	einfo "Install init.d script"
	newinitd "${FILESDIR}"/dcc.initd dcc

	rmdir "${D}"/var/dcc/log/
}
