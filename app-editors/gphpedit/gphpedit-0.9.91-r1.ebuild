# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gphpedit/gphpedit-0.9.91-r1.ebuild,v 1.6 2012/05/03 18:33:00 jdhore Exp $

EAPI="2"

inherit gnome2 eutils

DESCRIPTION="A Gnome2 PHP/HTML source editor"
HOMEPAGE="http://www.gphpedit.org/"
SRC_URI="http://www.gphpedit.org/download/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0:2
	>=dev-libs/glib-2.0:2
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gnome-vfs-2.0:2
	gnome-extra/gtkhtml:2"

DEPEND="${RDEPEND}
		sys-devel/gettext
		virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README TODO"

# Parallel build unhappy (bug #145351)
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.91-empty-apply-prefs.patch
	# Fix crash when finding and replacing, see bug #248497
	epatch "${FILESDIR}"/${PN}-0.9.91-find_replace.patch

	gnome2_src_prepare
}
