# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/lock-keys-applet/lock-keys-applet-1.0.ebuild,v 1.17 2012/05/05 06:25:23 jdhore Exp $

EAPI="4"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="An applet that shows the status of your Caps, Num and Scroll Lock keys"
HOMEPAGE="http://mfcn.ilo.de/led_applet"
SRC_URI="http://mfcn.ilo.de/led_applet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.21
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	gnome2_src_prepare

	# Drop DEPRECATED flags, bug #388019
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		src/Makefile.am src/Makefile.in || die

	# Fix intltool tests
	echo "GNOME_LockKeysApplet.server.in" >> po/POTFILES.in
}
