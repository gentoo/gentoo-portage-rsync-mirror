# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libnova/libnova-0.15.0.ebuild,v 1.3 2012/08/03 19:30:14 bicatali Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="Celestial Mechanics and Astronomical Calculation Library"
HOMEPAGE="http://libnova.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	sed -i -e '/CFLAGS=-Wall/d' configure.in || die
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	emake
	use doc && emake doc
}

src_install() {
	default
	use doc && dohtml doc/html/*
	if use examples; then
		make clean
		rm -f examples/Makefile*
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
