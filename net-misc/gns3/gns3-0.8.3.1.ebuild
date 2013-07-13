# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3/gns3-0.8.3.1.ebuild,v 1.3 2013/07/13 13:13:18 pinkbyte Exp $

EAPI="5"

PYTHON_DEPEND="2"

inherit distutils eutils

MY_P=${P/gns/GNS}-src

DESCRIPTION="Graphical Network Simulator"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="mirror://sourceforge/gns-3/GNS3/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
PYTHON_MODNAME="GNS3"

DEPEND="dev-qt/qtgui:4
	dev-qt/qtsvg:4
	>=dev-python/PyQt4-4.6.1[X,svg]"
RDEPEND="${DEPEND}
	>=app-emulation/dynamips-0.2.8_rc2"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Fix illegal install path; /usr/local
	epatch "${FILESDIR}"/${P}_install_path.patch
	python_convert_shebangs -r 2 .
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	doicon "${FILESDIR}/${PN}.xpm"
	make_desktop_entry "${PN}" "GNS3" "/usr/share/pixmaps/${PN}.xpm" "Utility" \
		|| die "make_desktop_entry failed"
	doman docs/man/${PN}.1
}

pkg_postinst() {
	ewarn "GNS3 has several dependencies that must be enabled manually for additional functionality."
	ewarn "The following is a list of dependencies that can be added:"
	ewarn "putty (terminal support), qemu (additional emulation), telnet, virtualbox (host emulation)"
}
