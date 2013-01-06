# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/geierlein/geierlein-0.3.4.ebuild,v 1.1 2012/10/01 21:24:40 hanno Exp $

EAPI=4

DESCRIPTION="Submit tax forms (Umsatzsteuervoranmeldung) to the german digital tax project ELSTER."
HOMEPAGE="http://stesie.github.com/geierlein/"
SRC_URI="https://github.com/downloads/stesie/geierlein/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND="www-client/firefox"
DEPEND=""

# needs nodejs and a couple of modules we don't have packaged
RESTRICT="test"

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix=/usr \
		install || die
	dodoc README.md
}
