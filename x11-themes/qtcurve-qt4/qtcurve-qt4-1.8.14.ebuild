# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qtcurve-qt4/qtcurve-qt4-1.8.14.ebuild,v 1.9 2013/10/01 21:47:30 pesa Exp $

EAPI=4
KDE_REQUIRED="optional"
inherit cmake-utils kde4-base

MY_P="${P/qtcurve-qt4/QtCurve-KDE4}"

DESCRIPTION="A set of widget styles for Qt4 based apps, also available for GTK2"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://craigd.wikispaces.com/file/view/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~ppc64 sparc x86"
IUSE="kde windeco"
REQUIRED_USE="windeco? ( kde )"

DEPEND="dev-qt/qtdbus:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	kde? (
		$(add_kdebase_dep systemsettings)
		windeco? ( $(add_kdebase_dep kwin) )
	)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS=( ChangeLog README TODO )
PATCHES=( "${FILESDIR}/${PN}_kwin_automagic_fix.patch" )

pkg_setup() {
	use kde && kde4-base_pkg_setup
}

src_configure() {
	local mycmakeargs
	if use kde; then
		mycmakeargs=(
			$(cmake-utils_use windeco QTC_KWIN)
		)
		kde4-base_src_configure
	else
		mycmakeargs=(
			"-DQTC_QT_ONLY=true"
		)
		cmake-utils_src_configure
	fi
}
