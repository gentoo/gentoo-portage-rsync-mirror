# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-3.3.2-r1.ebuild,v 1.5 2010/09/19 17:55:11 armin76 Exp $

inherit eutils

MY_P="${PN}-dnh${PV}"

DESCRIPTION="Enhanced CTorrent is a BitTorrent console client written in C and C++."
HOMEPAGE="http://www.rahul.net/dholmes/ctorrent/"
SRC_URI="mirror://sourceforge/dtorrent/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 arm ppc s390 sh ~sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND="dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-CVE-2009-1759.patch" || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README-DNH.TXT README NEWS
}
