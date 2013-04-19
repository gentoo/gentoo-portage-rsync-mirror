# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcoyotl/libcoyotl-3.1.0-r1.ebuild,v 1.1 2013/04/19 02:53:52 patrick Exp $

EAPI="5"

inherit eutils autotools

DESCRIPTION="A collection of portable C++ classes."
HOMEPAGE="http://www.coyotegulch.com/products/libcoyotl/"
SRC_URI="http://www.coyotegulch.com/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}/${PV}-gcc-4.3.patch" || die
	epatch "${FILESDIR}/${PV}-gcc-4.7.patch" || die
	eautoreconf
}

src_configure() {
	ac_cv_prog_HAVE_DOXYGEN="false" econf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		cd docs
		doxygen libcoyotl.doxygen || die "generating docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	if use doc ; then
		dohtml docs/html/* || die
	fi
}
