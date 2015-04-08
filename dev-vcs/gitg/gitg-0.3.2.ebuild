# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitg/gitg-0.3.2.ebuild,v 1.4 2014/11/24 05:29:49 tetromino Exp $

EAPI=5

VALA_MIN_API_VERSION="0.20"
PYTHON_COMPAT=( python{3_2,3_3} )

inherit autotools gnome2 python-r1 vala

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Gitg"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug glade +python"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# test if unbundling of libgd is possible
# Currently it seems not to be (unstable API/ABI)
RDEPEND="
	dev-libs/libgee:0.8[introspection]
	>=dev-libs/json-glib-0.16
	>=app-text/gtkspell-3.0.3:3
	>=dev-libs/glib-2.38:2
	>=dev-libs/gobject-introspection-0.10.1
	dev-libs/libgit2[threads]
	>=dev-libs/libgit2-glib-0.0.10
	<dev-libs/libgit2-glib-0.0.16
	>=dev-libs/libpeas-1.5.0[gtk]
	>=gnome-base/gsettings-desktop-schemas-0.1.1
	>=net-libs/webkit-gtk-2.2:3[introspection]
	>=x11-libs/gtk+-3.10.0:3
	>=x11-libs/gtksourceview-3.10:3.0
	>=x11-themes/gnome-icon-theme-symbolic-3.10
	glade? ( >=dev-util/glade-3.2:3.10 )
	python? (
		${PYTHON_DEPS}
		dev-libs/libpeas[python,${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	$(vala_depend)"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	sed \
		-e '/CFLAGS/s:-g::g' \
		-e '/CFLAGS/s:-O0::g' \
		-i configure.ac || die
	eautoreconf
	gnome2_src_prepare
	vala_src_prepare
}

src_configure() {
	# Disable maintainer to get rid of -Werror  (bug #363009)
	G2CONF="${G2CONF}
		--disable-static
		--disable-deprecations
		--disable-dependency-tracking
		$(use_enable debug)
		$(use_enable glade glade-catalog)
		$(use_enable python)"

	gnome2_src_configure
}

src_install() {
	gnome2_src_install -j1
}
