# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/gtk-cpuspeedy/gtk-cpuspeedy-0.3.0-r1.ebuild,v 1.7 2014/05/12 10:04:07 ssuominen Exp $

EAPI=5

DESCRIPTION="Graphical GTK+ 2 frontend for cpuspeedy"
HOMEPAGE="http://cpuspeedy.sourceforge.net/"
SRC_URI="mirror://sourceforge/cpuspeedy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

COMMON_DEPEND="x11-libs/gtk+:2"
RDEPEND="${COMMON_DEPEND}
	>=sys-power/cpuspeedy-0.2
	x11-libs/gksu"
DEPEND="${COMMON_DEPEND}
	sys-apps/texinfo
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README TODO"
