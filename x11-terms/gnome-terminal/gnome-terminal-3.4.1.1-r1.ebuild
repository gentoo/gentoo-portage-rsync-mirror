# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-3.4.1.1-r1.ebuild,v 1.2 2012/11/25 00:21:22 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

# FIXME: automagic dependency on gtk+[X]
RDEPEND=">=dev-libs/glib-2.26.0:2
	>=x11-libs/gtk+-3.3.17:3[X]
	>=x11-libs/vte-0.30.0:2.90
	>=gnome-base/gconf-2.31.3
	>=gnome-base/gsettings-desktop-schemas-0.1.0
	x11-libs/libSM
	x11-libs/libICE"
# gtk+:2 needed for gtk-builder-convert, bug 356239
DEPEND="${RDEPEND}
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3.11
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
	# FIXME: leave smclient configure unset until it accepts values from the
	# switch and not from GDK_TARGET, bug #363033
	G2CONF="${G2CONF} --with-gtk=3.0"
}

pkg_postinst() {
	gnome2_pkg_postinst
	if [[ ${REPLACING_VERSIONS} < 3.4.1.1-r1 && ${REPLACING_VERSIONS} != 2.32.1-r1 ]]; then
		elog "Gnome Terminal no longer uses login shell by default, switching"
		elog "to upstream default. Because of this, if you have some command you"
		elog "want to be run, be sure to have it placed in your ~/.bashrc file."
	fi
}
