# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/herqq/herqq-1.0.0-r1.ebuild,v 1.9 2014/01/02 18:46:17 pinkbyte Exp $

EAPI=4

inherit multilib base qt4-r2

DESCRIPTION="A software library for building UPnP devices"
HOMEPAGE="http://www.herqq.org"
SRC_URI="mirror://sourceforge/hupnp/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="doc"

# no release of QtSolutions using bundled libQtSolutions_SOAP
RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtxmlpatterns:4
	!media-libs/hupnp-ng
"
DEPEND="${RDEPEND}"

DOCS=( hupnp/ChangeLog )
HTML_DOCS=( hupnp/docs/html/ )

src_prepare() {
	# fix the .pro file for multilib issues
	sed \
		-e "s:PREFIX/lib:PREFIX/$(get_libdir):" \
		-i "${S}/hupnp/src.pro" \
		-i "${S}/hupnp/lib/qtsoap-2.7-opensource/buildlib/buildlib.pro" || die
	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 PREFIX="${EPREFIX}/usr/"
}

src_install() {
	qt4-r2_src_install
	use doc && base_src_install_docs
}
