# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist/zeitgeist-0.9.5-r1.ebuild,v 1.2 2013/04/24 06:47:12 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

AUTOTOOLS_AUTORECONF=true
VALA_MIN_API_VERSION=0.16

inherit autotools-utils eutils python-r1 versionator vala

DIR_PV=$(get_version_component_range 1-2)
EXT_VER=0.0.13

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="http://launchpad.net/zeitgeist/"
SRC_URI="http://launchpad.net/zeitgeist/${DIR_PV}/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+dbus extensions +fts icu nls passiv plugins sql-debug"

RDEPEND="
	dev-libs/xapian[inmemory]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/rdflib
	media-libs/raptor:2
	dev-libs/glib:2
	dev-db/sqlite:3
	extensions? ( gnome-extra/zeitgeist-extensions  )
	icu? ( dev-libs/dee[icu?] )
	passiv? ( gnome-extra/zeitgeist-datahub )
	plugins? ( gnome-extra/zeitgeist-datasources )"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${PN}-0.9.0-doc.patch )

src_prepare() {
	sed \
		-e 's:python::g' \
		-i Makefile.am || die
	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		$(use_enable sql-debug explain-queries)
		$(use_with icu dee-icu)
		$(use_with dbus session-bus-services-dir /usr/share/dbus-1/services)
	)
	use nls || myeconfargs+=(--disable-nls)
	use fts || myeconfargs+=(--disable-fts)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	cd python || die
	python_moduleinto ${PN}
	python_foreach_impl python_domodule *py
}
