# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tcpsound/tcpsound-0.3.1-r1.ebuild,v 1.4 2013/02/12 14:20:02 ago Exp $

EAPI="4"

inherit base toolchain-funcs

DESCRIPTION="Play sounds in response to network traffic"
HOMEPAGE="http://www.ioplex.com/~miallen/tcpsound/"
SRC_URI="http://www.ioplex.com/~miallen/tcpsound/dl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-analyzer/tcpdump
	media-libs/libsdl
	dev-libs/libmba"
RDEPEND="${DEPEND}"

DOCS=( README.txt elaborate.conf )
PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_prepare() {
	# Fix paths
	sed -i -e "s;/usr/share/sounds:/usr/local/share/sounds;/usr/share/tcpsound;g"\
		"${S}"/src/tcpsound.c "${S}"/elaborate.conf || die 'sed failed'

	base_src_prepare
}

src_compile() {
	emake CC="$(tc-getCC)"
}
