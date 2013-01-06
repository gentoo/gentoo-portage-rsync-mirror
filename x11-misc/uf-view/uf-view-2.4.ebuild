# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/uf-view/uf-view-2.4.ebuild,v 1.10 2012/05/16 09:59:21 hasufell Exp $

EAPI=1

inherit gnome2

DESCRIPTION="UF-View is a Gnome viewer for the UserFriendly comic"
HOMEPAGE="http://git.gnome.org/browse/archive/uf-view/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ppc"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README NEWS THANKS"
