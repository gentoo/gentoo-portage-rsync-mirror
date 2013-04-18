# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-3.8.1.ebuild,v 1.1 2013/04/18 19:35:46 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-3+"
SLOT="0"
IUSE="+nautilus"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux"

# FIXME: automagic dependency on gtk+[X]
RDEPEND="
	>=dev-libs/glib-2.33.2:2
	>=x11-libs/gtk+-3.6:3[X]
	>=x11-libs/vte-0.34.0:2.90
	>=gnome-base/gconf-2.31.3
	>=gnome-base/dconf-0.12
	>=gnome-base/gsettings-desktop-schemas-0.1.0
	x11-libs/libSM
	x11-libs/libICE
	nautilus? ( >=gnome-base/nautilus-3 )
"
# gtk+:2 needed for gtk-builder-convert, bug 356239
DEPEND="${RDEPEND}
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	app-text/yelp-tools
	>=dev-util/intltool-0.40
	>=gnome-base/dconf-0.14.0
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS"
	# FIXME: leave smclient configure unset until it accepts values from the
	# switch and not from GDK_TARGET, bug #363033
	gnome2_src_configure \
		--enable-migration \
		$(use_with nautilus nautilus-extension)
}

pkg_postinst() {
	gnome2_pkg_postinst
	if [[ ${REPLACING_VERSIONS} < 3.6.1-r1 && ${REPLACING_VERSIONS} != 2.32.1-r1 &&
		  ${REPLACING_VERSIONS} != 3.4.1.1-r1 ]]; then
		elog "Gnome Terminal no longer uses login shell by default, switching"
		elog "to upstream default. Because of this, if you have some command you"
		elog "want to be run, be sure to have it placed in your ~/.bashrc file."
	fi
}
