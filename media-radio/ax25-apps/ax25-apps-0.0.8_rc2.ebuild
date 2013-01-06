# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ax25-apps/ax25-apps-0.0.8_rc2.ebuild,v 1.4 2012/11/11 18:25:41 tomjbe Exp $

EAPI=4

MY_P=${P/_/-}

DESCRIPTION="Basic AX.25 (Amateur Radio) user tools, additional daemons"
HOMEPAGE="http://www.linux-ax25.org"
SRC_URI="http://www.linux-ax25.org/pub/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/libax25-0.0.12_rc2
	!media-sound/listen"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}

src_install() {
	default

	newinitd "${FILESDIR}"/ax25ipd.rc ax25ipd
	newinitd "${FILESDIR}"/ax25mond.rc ax25mond
	newinitd "${FILESDIR}"/ax25rtd.rc ax25rtd

	rm -rf "${ED}"/usr/share/doc/ax25-apps

	dodoc AUTHORS ChangeLog NEWS README ax25ipd/README.ax25ipd \
		ax25rtd/README.ax25rtd ax25ipd/HISTORY.ax25ipd ax25rtd/TODO.ax25rtd

	dodir /var/lib/ax25/ax25rtd
	touch "${ED}"/var/lib/ax25/ax25rtd/ax25_route
	touch "${ED}"/var/lib/ax25/ax25rtd/ip_route
}
