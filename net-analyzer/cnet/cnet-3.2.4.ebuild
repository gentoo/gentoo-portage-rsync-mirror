# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cnet/cnet-3.2.4.ebuild,v 1.1 2014/01/16 11:31:45 pinkbyte Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="Network simulation tool"
HOMEPAGE="http://www.csse.uwa.edu.au/cnet3/"
SRC_URI="${P}.tgz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=">=dev-lang/tk-8.5
	dev-libs/elfutils
	x11-libs/libX11"
RDEPEND="${DEPEND}"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Author demands to fill a download form to collect usage information:"
	einfo "${HOMEPAGE}/download.html"
	einfo "Please move downloaded file to ${DISTDIR}"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"

	# Set libdir properly
	sed -i -e "/CNETPATH/s:local/lib:$(get_libdir):" src/preferences.h || die
	sed -i -e "/^LIBDIR/s:lib:$(get_libdir):" Makefile || die

	epatch_user
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ANNOUNCE
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${P}/examples
	fi
}
