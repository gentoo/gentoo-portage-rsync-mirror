# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-polkit/mate-polkit-1.6.1.ebuild,v 1.1 2014/03/02 03:10:48 tomwij Exp $

EAPI="5"

inherit gnome2 versionator

RESTRICT="test"

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A MATE specific DBUS session bus service that is used to bring up authentication dialogs"
HOMEPAGE="https://github.com/mate-desktop/mate-polkit"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.28:2
	>=sys-auth/polkit-0.102:0[introspection?]
	sys-libs/glibc:2.2
	>=x11-libs/gtk+-2.24:2[introspection?]
	x11-libs/gdk-pixbuf:2[introspection?]
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.2:0 )"

# We call gtkdocize so we need to depend on gtk-doc.
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-1.3:0
	>=dev-util/intltool-0.35:0
	!<gnome-extra/polkit-gnome-0.102:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"

# Entropy PMS specific. This way we can install the pkg into the build chroots.
ENTROPY_RDEPEND="!lxde-base/lxpolkit"

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection)
}

src_compile() {
	emake -C polkitgtkmate libpolkit-gtk-mate-1.la
}

DOCS="AUTHORS HACKING NEWS README"
