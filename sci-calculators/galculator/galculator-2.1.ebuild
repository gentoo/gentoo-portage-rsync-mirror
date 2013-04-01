# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/galculator/galculator-2.1.ebuild,v 1.5 2013/04/01 17:55:48 ago Exp $

EAPI=5
GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="GTK+ based algebraic and RPN calculator"
HOMEPAGE="http://galculator.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/flex
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README THANKS doc/shortcuts"

src_prepare() {
	cat <<-EOF >> po/POTFILES.skip
	ui/about.ui
	ui/dispctrl_right_vertical.ui
	ui/main_frame_hildon.ui
	ui/prefs-ume.ui
	EOF

	gnome2_src_prepare
}
