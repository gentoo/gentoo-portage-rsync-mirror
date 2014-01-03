# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.32.1-r1.ebuild,v 1.12 2014/01/02 23:58:54 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

# libgnome needed for some monospace font schema, bug #274638
RDEPEND=">=dev-libs/glib-2.25.12:2
	>=x11-libs/gtk+-2.18:2
	>=gnome-base/gconf-2.31.3
	>=x11-libs/vte-0.26.0:0
	x11-libs/libICE
	x11-libs/libSM
	gnome-base/libgnome"
DEPEND="${RDEPEND}
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_prepare() {
	# fix underlinking, bug #496804; avoid eautoreconf
	sed -e 's/SMCLIENT_PKGS="sm"/SMCLIENT_PKGS="sm ice"/' -i configure.ac configure || die
	gnome2_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst
	if [[ ${REPLACING_VERSIONS} < 2.32.1-r1 ]]; then
		elog "Gnome Terminal no longer uses login shell by default, switching"
		elog "to upstream default. Because of this, if you have some command you"
		elog "want to be run, be sure to have it placed in your ~/.bashrc file."
	fi
}
