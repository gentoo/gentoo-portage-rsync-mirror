# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/IceE/IceE-1.3.0-r2.ebuild,v 1.1 2012/10/22 21:46:12 ago Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="A modern object-oriented middleware with support for C++, .NET, Java, Python, Ruby, and PHP"
HOMEPAGE="http://www.zeroc.com/icee/index.html"
SRC_URI="http://www.zeroc.com/download/${PN}/${PV/\.0//}/${P}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="mono"

DEPEND=">=sys-libs/db-4.6.21
		>=dev-libs/expat-1.95.7
		>=app-arch/bzip2-1.0.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/IceE-${PV}

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-makefile-2.patch"
	epatch "${FILESDIR}/${P}-gcc4.3-fix.patch"
	epatch "${FILESDIR}/${P}-maverick-fix.patch"
	epatch "${FILESDIR}/${P}-remove-explicit-rpath.patch"
	sed -i "s/DESTDIR_PLACE_HOLDER/${D//\//\\/}\/usr/" cppe/config/Make.rules || die
	tc-export CXX
}

src_compile() {
	if tc-is-cross-compiler ; then
		export CXX="${CHOST}-g++"
		export AR="${CHOST}-ar"
	fi

	emake configure
	emake LDFLAGS="${LDFLAGS}"
}

src_install() {
	dodir /usr/share/${PN}

	emake DESTDIR="${D}" install

	cd "${D}"/usr
	rm -rf LICENSE ICEE_LICENSE
	tc-is-cross-compiler && rm bin/slice2cppe

	mv "${D}"/usr/slice "${D}"/usr/share/${PN}
}
