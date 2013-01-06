# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-desktop/gnome-desktop-2.32.1-r1.ebuild,v 1.4 2012/12/19 07:50:45 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Libraries for the gnome desktop that are not part of the UI"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2+ FDL-1.1+ LGPL-2+"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="license-docs"

# Note: gnome-desktop:2 and :3 install identical files in /usr/share/gnome/help
# and /usr/share/omf when --enable-desktop-docs is passed to configure. To avoid
# file conflict and pointless duplication, gnome-desktop:2[doc] will simply use
# the files that are installed by :3[doc]
RDEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.19.1:2
	>=x11-libs/libXrandr-1.2
	>=gnome-base/gconf-2:2
	>=x11-libs/startup-notification-0.5"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.1.2
	x11-proto/xproto
	>=x11-proto/randrproto-1.2"
PDEPEND=">=dev-python/pygtk-2.8:2
	>=dev-python/pygobject-2.14:2
	license-docs? ( gnome-base/gnome-desktop:3[doc(+)] )"

# Includes X11/Xatom.h in libgnome-desktop/gnome-bg.c which comes from xproto
# Includes X11/extensions/Xrandr.h that includes randr.h from randrproto (and
# eventually libXrandr shouldn't RDEPEND on randrproto)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	G2CONF="${G2CONF}
		PYTHON=$(PYTHON -a)
		--with-gnome-distributor=Gentoo
		--disable-scrollkeeper
		--disable-static
		--disable-deprecations
		--disable-desktop-docs"
	# desktop-docs will be built by gnome-desktop:3
	DOCS="AUTHORS ChangeLog HACKING NEWS README"

	epatch "${FILESDIR}"/${P}-gold.patch
	gnome2_src_prepare
}
