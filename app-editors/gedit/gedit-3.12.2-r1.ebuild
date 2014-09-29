# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-3.12.2-r1.ebuild,v 1.1 2014/09/29 14:31:01 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes" # plugins are dlopened
PYTHON_COMPAT=( python3_{2,3} )

inherit eutils gnome2 multilib python-r1 virtualx

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="https://wiki.gnome.org/Apps/Gedit"

LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"

IUSE="+introspection +python spell zeitgeist"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"

# X libs are not needed for OSX (aqua)
COMMON_DEPEND="
	>=dev-libs/libxml2-2.5.0:2
	>=dev-libs/glib-2.39.5:2
	>=x11-libs/gtk+-3.11.6:3[introspection?]
	>=x11-libs/gtksourceview-3.11.2:3.0[introspection?]
	>=dev-libs/libpeas-1.7.0[gtk]

	gnome-base/gsettings-desktop-schemas
	gnome-base/gvfs

	x11-libs/libX11

	net-libs/libsoup:2.4

	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	python? (
		${PYTHON_DEPS}
		>=dev-libs/gobject-introspection-0.9.3
		>=x11-libs/gtk+-3:3[introspection]
		>=x11-libs/gtksourceview-3.6:3.0[introspection]
		dev-python/pycairo[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3:3[cairo,${PYTHON_USEDEP}] )
	spell? (
		>=app-text/enchant-1.2:=
		>=app-text/iso-codes-0.35 )
	zeitgeist? ( >=gnome-extra/zeitgeist-0.9.12 )
"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic
	python? ( dev-libs/libpeas[${PYTHON_USEDEP}] )
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/scrollkeeper-0.3.11
	dev-libs/libxml2:2
	>=dev-util/gtk-doc-am-1
	>=dev-util/intltool-0.50.1
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
"
# yelp-tools, gnome-common needed to eautoreconf

src_prepare() {
	# FIXME: Not able to set some metadata
	sed -e '/g_test_add_func/d' \
		-i tests/document-loader.c || die

	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"

	gedit_configure() {
		ECONF_SOURCE=${S} \
		gnome2_src_configure \
			--disable-deprecations \
			--enable-updater \
			--enable-gvfs-metadata \
			$(use_enable introspection) \
			$(use_enable spell) \
			$(use_enable zeitgeist) \
			ITSTOOL=$(type -P true) \
			"$@"
	}

	gedit_py_configure() {
		mkdir -p "${BUILD_DIR}" || die
		run_in_build_dir gedit_configure --enable-python
	}

	# run gedit_py_configure first to avoid out-of-source build for C code
	use python && python_parallel_foreach_impl gedit_py_configure
	gedit_configure --disable-python
}

src_test() {
	# FIXME: this should be handled at eclass level
	"${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/data" || die

	unset DBUS_SESSION_BUS_ADDRESS
	GSETTINGS_SCHEMA_DIR="${S}/data" Xemake check
}

src_install() {
	gedit_py_install() {
		pushd "${BUILD_DIR}" > /dev/null || die
		# manually set pyoverridesdir due to bug #524018 and AM_PATH_PYTHON limitations
		emake DESTDIR="${D}" top_builddir="${S}" pyoverridesdir="$(python_get_sitedir)/gi/overrides" install
		popd > /dev/null
	}

	gnome2_src_install
	use python && python_foreach_impl gedit_py_install
}
