# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pius/pius-2.0.8.ebuild,v 1.3 2014/08/10 02:26:59 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A tool for signing and email all UIDs on a set of PGP keys"
HOMEPAGE="http://www.phildev.net/pius/"
SRC_URI="mirror://sourceforge/pgpius/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}"

src_prepare() {
	python_convert_shebangs 2 ${PN}
}

src_install() {
	dobin ${PN}
	dodoc Changelog README
}
