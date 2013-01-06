# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist/zeitgeist-0.9.0-r1.ebuild,v 1.2 2012/05/05 06:25:21 jdhore Exp $

EAPI=4

PYTHON_DEPEND="2"

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils python versionator

DIR_PV=$(get_version_component_range 1-2)
EXT_VER=0.0.13

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="http://launchpad.net/zeitgeist/"
SRC_URI="http://launchpad.net/zeitgeist/${DIR_PV}/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dbus extensions +fts icu nls passiv plugins"

RDEPEND="
	dev-libs/xapian
	dev-python/dbus-python
	dev-python/pygobject:2
	dev-python/pyxdg
	dev-python/rdflib
	media-libs/raptor:2
	dev-libs/glib:2
	dev-lang/vala:0.14
	dev-db/sqlite:3
	extensions? ( gnome-extra/zeitgeist-extensions  )
	icu? ( dev-libs/dee[icu?] )
	passiv? ( gnome-extra/zeitgeist-datahub )
	plugins? ( gnome-extra/zeitgeist-datasources )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-gobject.patch
	"${FILESDIR}"/${P}-doc.patch
	)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	export VALAC=$(type -p valac-0.14)
}

src_prepare() {
	python_clean_py-compile_files
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--docdir=/usr/share/doc/${PF}
		$(use_with icu dee-icu)
		$(use_with dbus session-bus-services-dir /usr/share/dbus-1/services)
	)
	use nls || myeconfargs+=(--disable-nls)
	use fts || myeconfargs+=(--disable-fts)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
}

pkg_postinst() {
	python_mod_optimize zeitgeist
}

pkg_postrm() {
	python_mod_cleanup zeitgeist
}
