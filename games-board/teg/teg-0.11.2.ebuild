# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/teg/teg-0.11.2.ebuild,v 1.4 2011/01/24 21:53:41 mr_bones_ Exp $

EAPI=2
inherit gnome2

DESCRIPTION="Gnome Risk Clone"
HOMEPAGE="http://teg.sourceforge.net/"
SRC_URI="mirror://sourceforge/teg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND="dev-libs/glib:2
	|| ( >=gnome-base/libgnomeui-2.24.0 gnome-base/libgnomeui[jpeg] )
	gnome-base/libgnome
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	app-text/htmltidy
	nls? ( sys-devel/gettext )"
