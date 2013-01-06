# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/sgeps/sgeps-0_pre12.ebuild,v 1.1 2010/07/22 20:36:10 flameeyes Exp $

EAPI=2

DESCRIPTION="simple GnuPG-encrypted password store written in perl"
HOMEPAGE="http://roland.entierement.nu/blog/2010/01/22/simple-gnupg-encrypted-password-store.html"
SRC_URI="mirror://gentoo/${P}.pl.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-crypt/gnupg
	dev-lang/perl
	virtual/perl-Storable
	virtual/perl-File-Temp
	virtual/perl-Getopt-Long
	dev-perl/Config-Simple"
DEPEND=""

src_install() {
	newbin "${WORKDIR}/${P}.pl" "${PN}" || die "newbin failed"
}

pkg_postinst() {
	elog "To make use of sgeps, remember to create a configuration file as"
	elog " ~/.config/sgeps.conf with these values:"
	elog ""
	elog "store = ~/somewhere/safe"
	elog "keyid = 012345678"
	elog ""
}
