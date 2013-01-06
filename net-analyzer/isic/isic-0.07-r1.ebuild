# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/isic/isic-0.07-r1.ebuild,v 1.5 2012/09/26 10:42:15 blueness Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="IP Stack Integrity Checker"
HOMEPAGE="http://isic.sourceforge.net/"
SRC_URI="mirror://sourceforge/isic/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="net-libs/libnet:1.1"
RDEPEND="${DEPEND}"

src_prepare() {
	# Add two missing includes
	echo "#include <netinet/udp.h>" >> isic.h || die
	echo "#include <netinet/tcp.h>" >> isic.h || die

	# Install man pages in /usr/share/man
	sed -i Makefile.in -e 's|/man/man1|/share&|g' || die

	tc-export CC
}

src_configure() {
	# Build system does not know about DESTDIR
	econf --prefix="${D}/usr" --exec_prefix="${D}/usr"
}

src_install() {
	# Build system does not know about DESTDIR
	emake install || die "make install failed"
	dodoc README
}
