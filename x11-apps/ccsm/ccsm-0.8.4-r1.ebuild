# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/ccsm/ccsm-0.8.4-r1.ebuild,v 1.5 2012/08/29 10:14:37 naota Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Compizconfig Settings Manager"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/compizconfig-python-${PV}
	>=dev-python/pygtk-2.12:2
	gnome-base/librsvg
"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme"
DEPEND="${DEPEND}
	dev-util/intltool"

DOCS="AUTHORS"
PYTHON_MODNAME="ccm"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	distutils_src_compile --prefix=/usr
}

src_install() {
	distutils_src_install --prefix=/usr
}
