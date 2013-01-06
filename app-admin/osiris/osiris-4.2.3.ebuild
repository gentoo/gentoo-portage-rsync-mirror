# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/osiris/osiris-4.2.3.ebuild,v 1.4 2012/05/31 02:35:28 zmedico Exp $

inherit toolchain-funcs autotools eutils user

DESCRIPTION="File integrity verification system"
HOMEPAGE="http://osiris.shmoo.com/"
SRC_URI="http://osiris.shmoo.com/data/${P}.tar.gz
	http://osiris.shmoo.com/data/modules/mod_uptime.tar.gz
	http://osiris.shmoo.com/data/modules/mod_dns.tar.gz
	http://osiris.shmoo.com/data/modules/mod_nvram.tar.gz
	http://osiris.shmoo.com/data/modules/mod_ports.tar.gz"

LICENSE="OSIRIS"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.8c
	>=sys-libs/db-4.3"

pkg_setup()
{
	enewgroup osiris
	enewuser osiris -1 -1 /var/lib/osiris osiris
}

src_unpack()
{
	unpack ${P}.tar.gz
	cd "${WORKDIR}"
	unpack mod_uptime.tar.gz
	unpack mod_dns.tar.gz
	unpack mod_nvram.tar.gz
	unpack mod_ports.tar.gz
	# Add the above modules
	mv "${S}"/../mod_* "${S}"/src/osirisd/modules/
	# Respect LDFLAGS
	cd "${S}"
	sed -i "s:\$CFLAGS:& ${LDFLAGS} :" "${S}"/configure.ac
	sed -i -e "/^CPPFLAGS/s: =.* : = ${CXXFLAGS} :" \
		-e "/^LDFLAGS/s: =.* : = ${LDFLAGS} :" \
		"${S}"/src/osirisd/modules/Makefile.in
	sed -i "/^COMPILE/{n; s:\$(CFLAGS):& \$(LDFLAGS) :}" \
		"${S}"/src/osirisd/Makefile.in
	for x in $(find "${S}/src/osirisd/modules/" -name "Makefile"); do
		sed -i "s:\$(CFLAGS):& \$(LDFLAGS) :" $x
	done
	eautoconf
}

src_compile()
{
	econf --prefix=/var/lib --enable-fancy-cli=yes
	emake CC=$(tc-getCC) agent || die "agent build failed"
	emake CC=$(tc-getCC) console || die "management build failed"
}

src_install() {
	elog "Osiris Scanning Daemon Version $VERSION for $SYSTEM"
	elog "Copyright (c) 2006 Brian Wotring. All Rights Reserved."
	elog ""
	elog ""
	elog "This installation was configured and built to run as osiris"
	elog "     agent user name: osiris"
	elog "management user name: osiris"
	elog ""
	elog "This installation was configured and built to use osiris"
	elog "     agent root directory: /var/lib/osiris"
	elog "management root directory: /var/lib/osiris"
	elog ""
	elog "The username and directory will be created during the"
	elog "installation process if they do not already exist."
	elog ""
	elog "By installing this product you agree that you have read the"
	elog "LICENSE file and will comply with its terms. "
	elog ""
	elog "---------------------------------------------------------------------"
	elog ""

	dosbin src/osirisd/osirisd || die "dosbin failed"
	fowners root:0 /usr/sbin/osirisd
	fperms 0755 /usr/sbin/osirisd
	newinitd "${FILESDIR}"/osirisd-${PV} osirisd
	newconfd "${FILESDIR}"/osirisd_confd-${PV} osirisd

	dosbin src/cli/osiris || die "dosbin failed"
	fowners root:0 /usr/sbin/osiris
	fperms 0755 /usr/sbin/osiris

	dosbin src/osirismd/osirismd || die "dosbin failed"
	fowners osiris:osiris /usr/sbin/osirismd
	fperms 4755 /usr/sbin/osirismd

	newinitd "${FILESDIR}"/osirismd-${PV} osirismd
	newconfd "${FILESDIR}"/osirismd_confd-${PV} osirismd

	dodir /var/run
	dodir /var/lib
	diropts -o osiris -g osiris -m0750
	dodir /var/lib/osiris
	dodir /var/run/osiris
	keepdir /var/run/osiris

	cp -rf "${S}"/src/configs "${D}"/var/lib/osiris/
	chown -R osiris:osiris "${D}"/var/lib/osiris/*
	chmod -R 0750 "${D}"/var/lib/osiris/*
}

pkg_postrm()
{
	rm -rf /var/run/osiris

	elog "The directory /var/lib/osiris will not be removed. You may remove"
	elog "it manually if you will not be reinstalling osiris at a later time."
}
