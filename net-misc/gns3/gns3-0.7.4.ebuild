# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3/gns3-0.7.4.ebuild,v 1.1 2011/06/13 09:23:49 hwoarang Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit distutils eutils python

MY_P=${P/gns/GNS}-src

DESCRIPTION="Graphical Network Simulator"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="mirror://sourceforge/gns-3/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	>=dev-python/PyQt4-4.6.1"
RDEPEND="${DEPEND}
	>=app-emulation/dynamips-0.2.8_rc2"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}_set_dynamips_path.patch" \
		"${FILESDIR}/${P}_set_qemu_path.patch"
	python_convert_shebangs -r 2 .
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	insinto /usr/libexec/${PN}
	doins "${S}/qemuwrapper/qemuwrapper.py" \
		|| die "Failed to install qemuwrapper.py"
	doins "${S}/qemuwrapper/pemubin.py" \
		|| die "Failed to install pemubin.py"
	doicon "${FILESDIR}/${PN}.xpm" \
		|| die "Failed to install ${PN}.xpm"
	make_desktop_entry "${PN}" "GNS3" "/usr/share/pixmaps/${PN}.xpm" "Utility;Emulator" \
		|| die "make_desktop_entry failed"
	doman docs/man/${PN}.1 \
		|| die "Installing man pages failed"
}
