# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qtcurve/gtk-engines-qtcurve-1.8.15.ebuild,v 1.7 2012/12/07 22:58:53 ago Exp $

EAPI=4
inherit cmake-utils

MY_P=${P/gtk-engines-qtcurve/QtCurve-Gtk2}

DESCRIPTION="A set of widget styles for GTK2 based apps, also available for Qt4/KDE4"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=40492"
SRC_URI="http://craigd.wikispaces.com/file/view/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="mozilla"

CDEPEND="
	x11-libs/gtk+:2
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	mozilla? ( || (
		>=www-client/firefox-3.0
		>=www-client/firefox-bin-3.0
		>=www-client/icecat-3.0
	) )
"

S=${WORKDIR}/${MY_P}

DOCS="ChangeLog README TODO"

src_configure() {
	local mycmakeargs=(
		"-DQTC_OLD_MOZILLA=OFF"
		$(cmake-utils_use mozilla QTC_MODIFY_MOZILLA)
	)
	cmake-utils_src_configure
}
