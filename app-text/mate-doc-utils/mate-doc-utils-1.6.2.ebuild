# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mate-doc-utils/mate-doc-utils-1.6.2.ebuild,v 1.5 2014/05/02 12:24:31 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_{6,7} )

inherit gnome2 multilib python-r1 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Documentation utilities for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}
	app-text/rarian:0
	>=dev-libs/libxml2-2.6.12:2[python,${PYTHON_USEDEP}]
	>=dev-libs/libxslt-1.1.8:0
	virtual/libintl:0"

DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.4
	>=app-text/gnome-doc-utils-0.20.10:0[${PYTHON_USEDEP}]
	app-text/scrollkeeper-dtd:1.0
	>=dev-util/intltool-0.35:*
	>=mate-base/mate-common-1.6:0
	>=sys-apps/gawk-3:0
	sys-devel/gettext:*
	virtual/pkgconfig:*"

src_prepare() {
	gnome2_src_prepare

	# Leave shebang alone.
	sed -e '/s+^#!.*python.*+#/d' \
		-i xml2po/xml2po/Makefile.{am,in} || die

	python_prepare() {
		mkdir -p "${BUILD_DIR}"
	}

	python_foreach_impl python_prepare
}

src_configure() {
	ECONF_SOURCE="${S}" python_foreach_impl run_in_build_dir gnome2_src_configure
}

src_compile() {
	python_foreach_impl run_in_build_dir emake -j1
}

src_test() {
	python_foreach_impl run_in_build_dir emake check
}

src_install() {
	dodoc AUTHORS ChangeLog NEWS README

	python_foreach_impl run_in_build_dir gnome2_src_install

	# Uncomment the below line when we stop relying on gnome-doc-utils.
	#python_replicate_script "${ED}"/usr/bin/xml2po

	# Remove xml2po, already provided by gnome-doc-utils.
	rm -rf "${ED}"usr/$(get_libdir)/python*/site-packages/xml2po || die
	rm -rf "${ED}"usr/bin/xml2po || die
	rm -rf "${ED}"usr/share/man/man*/xml2po* || die
	rm -rf "${ED}"usr/share/pkgconfig/xml2po* || die
	rm -rf "${ED}"usr/share/xml/mallard/*/mallard.{rnc,rng} || die
}
