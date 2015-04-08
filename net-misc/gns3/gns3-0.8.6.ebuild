# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3/gns3-0.8.6.ebuild,v 1.2 2015/04/08 18:04:50 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 eutils

MY_P="GNS3-${PV}"

DESCRIPTION="Graphical Network Simulator"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="mirror://sourceforge/gns-3/GNS3/${PV}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtgui:4
	dev-qt/qtsvg:4
	>=dev-python/PyQt4-4.6.1[X,svg,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=app-emulation/dynamips-0.2.10"

S="${WORKDIR}/${PN}-legacy-${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-0.8.4_install_path.patch" )

python_install_all() {
	distutils-r1_python_install_all

	doicon "${FILESDIR}/${PN}.xpm"
	make_desktop_entry "${PN}" "GNS3" "/usr/share/pixmaps/${PN}.xpm" "Utility"
	doman docs/man/${PN}.1
}

pkg_postinst() {
	ewarn "GNS3 has several dependencies that must be enabled manually for additional functionality."
	ewarn ""
	ewarn "The following is a list of dependencies that can be added:"
	ewarn "putty (terminal support), qemu (additional emulation), telnet, virtualbox (host emulation)"
	ewarn "if you require these dependencies please emerge them before gns3"
	ewarn ""
	ewarn "This will also require manual configuration in gns3's preferences to point to the proper path"
}
