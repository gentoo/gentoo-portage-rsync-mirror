# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ddrescue/ddrescue-1.17-r1.ebuild,v 1.1 2014/01/05 21:22:56 robbat2 Exp $

EAPI=5

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Copy data from one file or block device to another with read-error recovery"
HOMEPAGE="http://www.gnu.org/software/ddrescue/ddrescue.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.lz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~amd64-linux"
IUSE="static"

DEPEND="app-arch/lzip"
RDEPEND=""

src_unpack() {
	# Upstream only provides an lzip compressed tarball for this version
	tar --lzip -xf "${DISTDIR}"/${P}.tar.lz || die
}

src_configure() {
	use static && append-ldflags -static

	# not a normal configure script
	econf \
		--prefix="${EPREFIX}"/usr \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CPPFLAGS="${CPPFLAGS}" \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_test() {
	./testsuite/check.sh "${S}"/testsuite || die
}

src_install() {
	emake DESTDIR="${D}" install install-man
	dodoc ChangeLog README NEWS AUTHORS
}
