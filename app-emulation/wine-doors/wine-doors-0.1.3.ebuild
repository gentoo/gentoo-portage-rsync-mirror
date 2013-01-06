# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine-doors/wine-doors-0.1.3.ebuild,v 1.3 2011/04/06 18:30:55 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Wine-doors is a package manager for wine."
HOMEPAGE="http://www.wine-doors.org"
SRC_URI="http://www.wine-doors.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pycairo
	dev-python/pygtk
	dev-python/librsvg-python
	gnome-base/libglade
	dev-libs/libxml2[python]
	app-pda/orange
	app-arch/cabextract
	app-emulation/wine"
RDEPEND="${DEPEND}
	dev-python/gconf-python"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	USER="root" distutils_src_install --temp="${D}"
	keepdir /etc/wine-doors
}

pkg_postinst() {
	python_mod_optimize /usr/share/wine-doors
}

pkg_postrm() {
	python_mod_cleanup /usr/share/wine-doors
}
