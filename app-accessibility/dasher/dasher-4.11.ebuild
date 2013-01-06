# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-4.11.ebuild,v 1.13 2012/05/03 01:48:59 jdhore Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

IUSE="accessibility cairo gnome nls"

# The package claims to support 'qte', but it hasn't been tested.
# Any patches from someone who can test it are welcome.
# <leonardop@gentoo.org>
RDEPEND=">=dev-libs/glib-2.16:2
	dev-libs/expat
	>=x11-libs/gtk+-2.6:2
	>=gnome-base/gconf-2:2
	x11-libs/libX11
	x11-libs/libXtst
	accessibility? (
		app-accessibility/gnome-speech
		>=gnome-base/libbonobo-2
		>=gnome-base/orbit-2
		>=gnome-base/libgnomeui-2
		gnome-extra/at-spi:1
		dev-libs/atk )
	cairo? ( >=x11-libs/gtk+-2.8:2 )
	gnome? (
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xproto
	gnome? (
		>=app-text/gnome-doc-utils-0.3.2
		app-text/scrollkeeper )
	nls? ( >=dev-util/intltool-0.41 )"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	# we might want to support japanese and chinese input at some point
	# --enable-japanese
	# --enable-chinese
	# --enable-tilt (tilt sensor support)

	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--with-gvfs
		$(use_enable accessibility a11y)
		$(use_enable accessibility speech)
		$(use_with cairo)
		$(use_with gnome)
		$(use_enable nls)"
}

src_prepare() {
	# configure.ac has a typo for AM_GCONF_SOURCE2
	# beware if adding src_prepare + eautoreconf
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
		|| die "sed 1 failed"
}
