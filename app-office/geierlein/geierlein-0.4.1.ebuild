# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/geierlein/geierlein-0.4.1.ebuild,v 1.1 2012/12/18 22:15:30 hanno Exp $

EAPI=4

DESCRIPTION="Submit tax forms (Umsatzsteuervoranmeldung) to the german digital tax project ELSTER."
HOMEPAGE="http://stesie.github.com/geierlein/"
SRC_URI="https://github.com/stesie/geierlein/archive/V0.4.1.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND="www-client/firefox"
DEPEND=""

# needs nodejs and a couple of modules we don't have packaged
RESTRICT="test"

src_compile() {
	emake prefix=/usr
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix=/usr \
		install || die
	dodoc README.md
}
