# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/screenlets/screenlets-0.1.2.ebuild,v 1.2 2011/04/11 20:52:51 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Screenlets are small owner-drawn applications"
HOMEPAGE="http://www.screenlets.org"
SRC_URI="http://code.launchpad.net/screenlets/trunk/${PV}/+download/screenlets-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+svg"

RDEPEND="dev-python/dbus-python
	svg? ( dev-python/librsvg-python )
	dev-python/libwnck-python
	dev-python/gnome-keyring-python
	dev-python/pyxdg
	x11-libs/libnotify
	x11-misc/xdg-utils"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs -r 2 src
	sed -e "s/exec python/&2/" -i src/bin/* || die "sed failed"
}

src_install() {
	distutils_src_install

	insinto /usr/share/desktop-directories
	doins desktop-menu/desktop-directories/Screenlets.directory || die "doins failed"

	insinto /usr/share/icons
	doins desktop-menu/screenlets.svg || die "doins failed"

	# Insert .desktop files
	domenu desktop-menu/*.desktop || die "domenu failed"
}
