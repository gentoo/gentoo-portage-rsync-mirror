# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/note/note-1.3.3.ebuild,v 1.7 2008/01/24 18:14:16 nixnut Exp $

inherit perl-app

DESCRIPTION="A note taking perl program"
HOMEPAGE="http://www.daemon.de/NOTE"
SRC_URI="http://www.daemon.de/files/mirror/ftp.daemon.de/scip/Apps/note/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="crypt dbm general mysql text"

# inherit perl-app cause depend on dev-lang/perl
DEPEND="dev-perl/TermReadKey
	dev-perl/Term-ReadLine-Perl
	virtual/perl-Storable
	dev-perl/config-general
	crypt? ( dev-perl/crypt-cbc dev-perl/Crypt-Blowfish dev-perl/Crypt-DES )
	mysql? ( virtual/mysql dev-perl/DBD-mysql )"

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"

	# Adding some basic utitily for testing note
	dodir /usr/share/${PN}
	cp "${S}/bin/stresstest.sh" "${D}/usr/share/${PN}"

	# Adding some help for mysql backend driver
	if use mysql; then
		dodir /usr/share/${PN}/mysql
		cp -r "${S}/mysql" "${D}/usr/share/${PN}"
	fi

	# Adding a sample configuration file
	dodir /etc
	cp "${S}/config/noterc" "${D}/etc"

	# Supressing file not needed
	for v in mysql text dbm general; do
		if ! use ${v}; then
			for u in `find "${D}" -type f -name *${v}.*pm`; do
				rm "${u}"
			done
		fi
	done

	dodoc README Changelog TODO UPGRADE VERSION
}
