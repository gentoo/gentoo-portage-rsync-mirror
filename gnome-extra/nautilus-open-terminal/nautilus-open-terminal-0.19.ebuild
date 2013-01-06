# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-open-terminal/nautilus-open-terminal-0.19.ebuild,v 1.3 2012/05/05 06:25:16 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit gnome2

DESCRIPTION="Nautilus Plugin for Opening Terminals"
HOMEPAGE="http://manny.cluecoder.org/packages/nautilus-open-terminal/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-2.4:2
	>=dev-libs/glib-2.16:2
	>=gnome-base/nautilus-2.91.90
	>=gnome-base/gnome-desktop-2.91.90:3
	gnome-base/gconf:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

pkg_setup() {
	DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"
	G2CONF="${G2CONF} --disable-static --disable-maintainer-mode"
}

src_prepare() {
	gnome2_src_prepare

	# Be a bit more future proof, bug #260903
	sed "s/-Werror//" -i src/Makefile.am src/Makefile.in || die "sed failed"

	# Fix intltoolize broken file, see upstream #577133
	#sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in || die "sed failed"
}
