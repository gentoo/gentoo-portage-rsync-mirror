# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.9.12.ebuild,v 1.7 2012/10/02 19:29:38 zerochaos Exp $

EAPI="2"
inherit eutils gnome2

DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
HOMEPAGE="http://etherape.sourceforge.net/"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libglade-2.0
	gnome-base/libgnomecanvas[glade]
	>=gnome-base/libgnomeui-2.0
	net-libs/libpcap"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=sys-devel/gettext-0.11.5
	app-text/gnome-doc-utils
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog FAQ NEWS README* TODO"
