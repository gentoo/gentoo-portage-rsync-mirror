# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-swallow/gnome-swallow-1.2.ebuild,v 1.12 2012/05/21 19:03:24 tetromino Exp $

EAPI="3"

inherit autotools eutils gnome2

DESCRIPTION="An applet for Gnome that 'swallows' normal apps. Useful for docks that are made for other DEs or WMs"
HOMEPAGE="http://interreality.org/~tetron/technology/swallow/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libgtop-2:2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=x11-libs/gtk+-2.2.1:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --docdir=/usr/share/doc/${PF}"
}

src_prepare() {
	gnome2_src_prepare

	# Fix compilation with --as-needed, bug #247521
	epatch "${FILESDIR}/${P}-as-needed.patch"

	# Fix compilation error, due to missing libgnomeui FLAGS
	epatch "${FILESDIR}/${P}-libgnomeui-flags.patch"

	# Fix qa warnings, due to missing stdlib.h and unistd.h headers
	epatch "${FILESDIR}/${P}-qa-warning.patch"

	eautoreconf
}
