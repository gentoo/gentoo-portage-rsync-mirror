# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-3.5.2-r1.ebuild,v 1.2 2013/03/02 19:38:15 hwoarang Exp $

EAPI=4

inherit base qt4-r2 versionator

# The upstream version numbering is bad, so we have to remove a dot in the
# minor version number
MAJOR="$(get_major_version)"
MINOR_1="$(($(get_version_component_range 2)/10))"
MINOR_2="$(($(get_version_component_range 2)%10))"
if [ ${MINOR_2} -eq "0" ] ; then
	MY_P="${PN}-${MAJOR}.${MINOR_1}"
else
	MY_P="${PN}-${MAJOR}.${MINOR_1}.${MINOR_2}"
fi

MY_P="${P}"

DESCRIPTION="A nice LaTeX-IDE"
HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

COMMON_DEPEND="
	app-text/hunspell
	app-text/poppler[qt4]
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	dev-qt/qtgui:4
	dev-qt/qtcore:4
	dev-qt/qtwebkit:4
"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/psutils
	app-text/ghostscript-gpl
	media-libs/netpbm"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-hunspell.patch
	"${FILESDIR}"/${P}-clang.patch
	)
src_configure() {
	eqmake4 \
		${PN}.pro \
		PREFIX="${EPREFIX}"/usr \
		DESKTOPDIR=/usr/share/applications \
		ICONDIR=/usr/share/pixmaps
}

src_install() {
	emake INSTALL_ROOT="${ED}" install

	doicon utilities/texmaker*.png utilities/texmaker.svg

	dodoc utilities/AUTHORS utilities/CHANGELOG.txt
}

pkg_postinst() {
	elog "A user manual with many screenshots is available at:"
	elog "${EPREFIX}/usr/share/${PN}/usermanual_en.html"
}
