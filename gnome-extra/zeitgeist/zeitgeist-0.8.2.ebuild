# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist/zeitgeist-0.8.2.ebuild,v 1.3 2012/02/16 19:49:01 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils python versionator

DIR_PV=$(get_version_component_range 1-2)
EXT_VER=0.0.13

DESCRIPTION="Service to log activities and present to other apps"
HOMEPAGE="http://launchpad.net/zeitgeist/"
SRC_URI="http://launchpad.net/zeitgeist/${DIR_PV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extensions passiv plugins"

RDEPEND="
	dev-python/dbus-python
	dev-python/pygobject:2
	dev-python/pyxdg
	dev-python/rdflib
	media-libs/raptor:2
	extensions? ( gnome-extra/zeitgeist-extensions  )
	passiv? ( gnome-extra/zeitgeist-datahub )
	plugins? ( gnome-extra/zeitgeist-datasources )
"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	autotools-utils_src_install
	python_convert_shebangs -r 2 "${ED}"
}

pkg_postinst() {
	python_mod_optimize zeitgeist
	python_mod_optimize /usr/share/zeitgeist/
}

pkg_postrm() {
	python_mod_cleanup zeitgeist
	python_mod_cleanup /usr/share/zeitgeist/
}
