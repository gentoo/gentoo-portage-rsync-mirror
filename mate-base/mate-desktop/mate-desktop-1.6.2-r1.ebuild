# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-base/mate-desktop/mate-desktop-1.6.2-r1.ebuild,v 1.1 2014/03/24 15:05:46 tomwij Exp $

EAPI="5"

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_6 python2_7 )

inherit gnome2 multilib python-r1 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Libraries for the MATE desktop that are not part of the UI"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X startup-notification"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.34:2
	>=dev-libs/libunique-1:1
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.4:2
	>=x11-libs/gtk+-2.24:2
	x11-libs/libX11:0
	>=x11-libs/libXrandr-1.2:0
	virtual/libintl:0
	startup-notification? ( >=x11-libs/startup-notification-0.5:0 )"

# Include X11/Xatom.h in libgnome-desktop/gnome-bg.c which comes from xproto, 
# include X11/extensions/Xrandr.h that includes randr.h comes from randrproto 
# (and eventually libXrandr shouldn't RDEPEND on randrproto).
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/mate-doc-utils-1.6:0
	>=dev-util/intltool-0.40:*
	sys-devel/gettext:*
	>=x11-proto/randrproto-1.2:0
	x11-proto/xproto:0
	virtual/pkgconfig:*"

src_configure() {
	gnome2_src_configure \
		--enable-mate-conf-import \
		--with-gtk=2.0 \
		$(use_with X x) \
		$(use_enable startup-notification)
}

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_install() {
	gnome2_src_install

	python_replicate_script "${ED}"/usr/bin/mate-conf-import
}
