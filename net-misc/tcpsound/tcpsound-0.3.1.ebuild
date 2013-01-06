# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tcpsound/tcpsound-0.3.1.ebuild,v 1.6 2012/11/18 06:48:19 pinkbyte Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Play sounds in response to network traffic"
HOMEPAGE="http://www.ioplex.com/~miallen/tcpsound/"
SRC_URI="http://www.ioplex.com/~miallen/tcpsound/dl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="net-analyzer/tcpdump
	media-libs/libsdl
	dev-libs/libmba"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	tc-export CC
	sed -i -e "s;/usr/share/sounds:/usr/local/share/sounds;/usr/share/tcpsound;g"\
		"${S}"/src/tcpsound.c "${S}"/elaborate.conf

	sed -i -e "s;/share/sounds;/share/tcpsound;g"\
		"${S}"/Makefile
	emake || die "emake failed"
}

src_install() {
	# Makefile expects /usr/bin to be there...
	emake DESTDIR="${D}" install || die

	dodoc README.txt elaborate.conf
}
