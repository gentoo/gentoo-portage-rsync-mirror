# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3/gns3-0.8.4.ebuild,v 1.2 2013/09/05 19:02:09 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python2_{6,7} )
inherit distutils-r1 eutils

MY_P="GNS3-${PV}-src"

DESCRIPTION="Graphical Network Simulator"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="mirror://sourceforge/gns-3/GNS3/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtgui:4
	dev-qt/qtsvg:4
	>=dev-python/PyQt4-4.6.1[X,svg,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=app-emulation/dynamips-0.2.8_rc4"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}_install_path.patch" )

src_install() {
	distutils-r1_src_install

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
