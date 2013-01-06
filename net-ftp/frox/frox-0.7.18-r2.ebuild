# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/frox/frox-0.7.18-r2.ebuild,v 1.4 2012/07/29 17:18:36 armin76 Exp $

inherit eutils

IUSE="clamav"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A transparent ftp proxy"
SRC_URI="http://frox.sourceforge.net/download/${MY_P}.tar.bz2"
HOMEPAGE="http://frox.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"

DEPEND="clamav? ( >=app-antivirus/clamav-0.80 )"

pkg_setup() {
	enewgroup ftpproxy
	enewuser ftpproxy -1 -1 /var/spool/frox ftpproxy
}

src_compile() {

	econf \
		--sbindir=/usr/sbin \
		--localstatedir=/var/run \
		--sysconfdir=/etc \
		--enable-http-cache --enable-local-cache \
		$(use_enable clamav virus-scan) || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	keepdir /var/run/frox
	keepdir /var/spool/frox
	keepdir /var/log/frox

	fperms 700 /var/spool/frox
	fowners ftpproxy:ftpproxy /var/run/frox /var/spool/frox /var/log/frox

	# INSTALL has useful filewall rules
	dodoc BUGS README \
		doc/CREDITS doc/ChangeLog doc/FAQ doc/INSTALL \
		doc/INTERNALS doc/README.transdata doc/RELEASE \
		doc/SECURITY doc/TODO

	dohtml doc/*.html doc/*.sgml

	mv doc/frox.man doc/frox.man.8
	mv doc/frox.conf.man doc/frox.conf.man.8
	doman doc/frox.man.8 doc/frox.conf.man.8

	newinitd ${FILESDIR}/frox.rc frox

	cd src
	epatch ${FILESDIR}/config-${PV}.patch || die "config patch failed"

	if use clamav; then
		sed -e "s:^# VirusScanner.*:# VirusScanner '\"/usr/bin/clamscan\" \"%s\"':" \
			frox.conf > ${D}/etc/frox.conf.example
		ewarn "Virus scanner potentialy broken in chroot - see bug #81035."
	else
		cp frox.conf ${D}/etc/frox.conf.example
	fi
}
