# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/galculator/galculator-1.3.4.ebuild,v 1.11 2013/05/01 04:13:20 tetromino Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="GTK+ based algebraic and RPN calculator."
HOMEPAGE="http://galculator.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="dev-libs/glib:2
	gnome-base/libglade:2.0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango
	gnome-base/libglade:2.0"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/flex
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	# Fix tests
	echo ui/*.glade | tr -t ' ' '\n' >> po/POTFILES.in

	# bug #415717, https://sourceforge.net/tracker/?func=detail&aid=3526340&group_id=80471&atid=559874
	epatch "${FILESDIR}/${P}-libm.patch"
	eautoreconf
}
