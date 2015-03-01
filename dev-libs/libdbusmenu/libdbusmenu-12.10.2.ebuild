# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-12.10.2.ebuild,v 1.5 2014/08/20 11:25:43 armin76 Exp $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils eutils flag-o-matic python-single-r1 vala multibuild multilib-minimal

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="http://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/${PN/lib}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug gtk gtk3 +introspection"

RDEPEND="
	>=dev-libs/dbus-glib-0.100[${MULTILIB_USEDEP}]
	>=dev-libs/json-glib-0.13.4[${MULTILIB_USEDEP}]
	>=dev-libs/glib-2.32[${MULTILIB_USEDEP}]
	dev-libs/libxml2[${MULTILIB_USEDEP}]
	gtk3? ( >=x11-libs/gtk+-3.2:3[introspection?,${MULTILIB_USEDEP}] )
	gtk? ( x11-libs/gtk+:2[${MULTILIB_USEDEP}] )
	introspection? ( >=dev-libs/gobject-introspection-1 )
	!<${CATEGORY}/${PN}-0.5.1-r200"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/intltool
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	introspection? ( $(vala_depend) )"

get_my_multibuild_variants() {
	echo "$(usex gtk 2) $(usex gtk3 3)"
}

src_prepare() {
	if use introspection; then
		vala_src_prepare
		export VALA_API_GEN="${VAPIGEN}"
	fi
	python_fix_shebang tools
}

multilib_src_configure() {
	local MULTIBUILD_VARIANTS=( $(get_my_multibuild_variants) )

	myconfigure() {
		append-flags -Wno-error #414323

		# dumper extra tool is only for GTK+-2.x, tests use valgrind which is stupid
		myeconfargs=(
			--docdir=/usr/share/doc/${PF}
			--disable-static
			--disable-silent-rules
			--disable-scrollkeeper
			$(use_enable gtk3 gtk)
			--disable-dumper
			$(multilib_native_use_enable introspection)
			$(multilib_native_use_enable introspection vala)
			$(use_enable debug massivedebugging)
			--with-html-dir=/usr/share/doc/${PF}/html
			--with-gtk=${MULTIBUILD_VARIANT}
		)
		autotools-utils_src_configure
	}
	multibuild_foreach_variant myconfigure
}

multilib_src_compile() {
	local MULTIBUILD_VARIANTS=( $(get_my_multibuild_variants) )
	multibuild_foreach_variant autotools-utils_src_compile
}

src_test() { :; } #440192

multilib_src_install() {
	local MULTIBUILD_VARIANTS=( $(get_my_multibuild_variants) )

	myinstall() {
		MAKEOPTS+=" -j1"
		autotools-utils_src_install
	}
	multibuild_foreach_variant myinstall
}

multilib_src_install_all() {
	DOCS=( AUTHORS ChangeLog NEWS README )
	einstalldocs

	local a b
	for a in ${PN}-{glib,gtk}; do
		b=/usr/share/doc/${PF}/html/${a}
		[[ -d ${ED}/${b} ]] && dosym ${b} /usr/share/gtk-doc/html/${a}
	done

	prune_libtool_files
}
