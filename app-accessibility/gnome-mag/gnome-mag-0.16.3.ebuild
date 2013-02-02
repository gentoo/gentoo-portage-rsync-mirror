# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.16.3.ebuild,v 1.9 2013/02/02 22:18:25 ago Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit eutils gnome2 virtualx

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.11.1:2
	>=x11-libs/gtk+-2.14:2"

# FIXME: need libcolorblind (debian package)
# python deps are for applets
#	applet? (
#		>=dev-python/pygtk-2.6
#		dev-python/pygobject
#
#		>=dev-python/libbonobo-python-2.10
#		>=dev-python/gconf-python-2.10
#		>=dev-python/libgnome-python-2.10
#		>=dev-python/gnome-applets-python-2.10 )

RDEPEND="${RDEPEND}
	>=gnome-base/libbonobo-1.107
	>=gnome-extra/at-spi-1.5.2:1
	>=gnome-base/orbit-2.3.100

	dev-libs/dbus-glib

	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXcomposite"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.35

	x11-proto/xextproto
	x11-proto/xproto"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --disable-colorblind-applet"
}

src_prepare() {
	gnome2_src_prepare

	# Workaround intltool tests failure
	echo "colorblind/GNOME_Magnifier_ColorblindApplet.server.in.in
colorblind/data/Colorblind_Applet.xml
colorblind/data/colorblind-applet.schemas.in
colorblind/data/colorblind-prefs.ui
colorblind/ui/About.py
colorblind/ui/ColorblindPreferencesUI.py
colorblind/ui/WindowUI.py" >> "${S}"/po/POTFILES.skip

	# Do not mess with CFLAGS
	sed -e 's/CFLAGS="$CFLAGS -Werror"//' \
		-e '/_DISABLE_DEPRECATED/d' \
		-i configure.in configure || die "sed failed"
}

src_test() {
	Xemake check || die "emake check failed"
}
