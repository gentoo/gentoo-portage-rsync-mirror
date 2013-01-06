# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/IceE/IceE-1.3.0-r1.ebuild,v 1.1 2009/07/28 08:02:49 b33fc0d3 Exp ${P}.ebuild,v 1.1 2009/01/07 15:24:59 b33fc0d3 Exp $

inherit eutils mono multilib toolchain-funcs

DESCRIPTION="The Internet Communications Engine (Ice) is a modern object-oriented middleware with support for C++, .NET, Java, Python, Ruby, and PHP"
HOMEPAGE="http://www.zeroc.com/icee/index.html"
SRC_URI="http://www.zeroc.com/download/IceE/${PV/\.0//}/IceE-${PV}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~x86"
IUSE="mono"

DEPEND=">=sys-libs/db-4.6.21
		>=dev-libs/expat-1.95.7
		>=app-arch/bzip2-1.0.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/IceE-${PV}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-makefile-2.patch"
	epatch "${FILESDIR}/${P}-gcc4.3-fix.patch"
	epatch "${FILESDIR}/${P}-maverick-fix.patch"
	epatch "${FILESDIR}/${P}-remove-explicit-rpath.patch"
}

src_compile() {
	if tc-is-cross-compiler ; then
		export CXX="${CHOST}-g++"
		export AR="${CHOST}-ar"
	fi

	sed -i "s/DESTDIR_PLACE_HOLDER/${D//\//\\/}\/usr/" cppe/config/Make.rules

	emake configure || die 'emake configure failed'
	emake || die 'emake failed'
}

src_install() {
	dodir /usr/share/${PN}

	emake install || die 'emake install failed'

	cd "${D}"/usr
	rm -rf LICENSE ICEE_LICENSE
	tc-is-cross-compiler && rm bin/slice2cppe

	mv "${D}"/usr/slice "${D}"/usr/share/${PN}
}
