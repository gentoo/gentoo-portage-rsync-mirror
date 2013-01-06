# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt-glib/libvirt-glib-0.1.3.ebuild,v 1.1 2012/10/08 15:44:22 cardoe Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.14"

inherit gnome2 python vala

DESCRIPTION="GLib and GObject mappings for libvirt"
HOMEPAGE="http://libvirt.org/git/?p=libvirt-glib.git"
SRC_URI="ftp://libvirt.org/libvirt/glib/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection python +vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	dev-libs/libxml2:2
	>=app-emulation/libvirt-0.9.10
	>=dev-libs/glib-2.10:2
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )
	vala? ( $(vala_depend) )"

src_prepare() {
	use vala && vala_src_prepare
}

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="--disable-test-coverage
		$(use_enable introspection)
		$(use_enable vala)
		$(use_with python)"

	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	emake -j1
}
