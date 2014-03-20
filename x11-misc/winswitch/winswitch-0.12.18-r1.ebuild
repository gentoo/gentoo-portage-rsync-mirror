# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/winswitch/winswitch-0.12.18-r1.ebuild,v 1.3 2014/03/20 21:45:26 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="client server tool to start and control virtual desktops"
HOMEPAGE="http://winswitch.org"
SRC_URI="http://winswitch.org/src/${P}.src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-python/gst-python[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/notify-python[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/twisted-core
	dev-python/twisted-conch
	media-gfx/xloadimage
	virtual/python-imaging[${PYTHON_USEDEP}]
	x11-misc/devilspie"
DEPEND=""

PATCHES=( "${FILESDIR}"/${P}-PIL.patch )

python_prepare_all() {
	einfo "Remove bundled Vash"
	rm -rf skel/share/Vash || die
	export PREFIX="${EPREFIX}"
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	elog "You might want to install following packages for additional protocol functionality"
	elog "    net-misc/tigervnc[?server]"
	elog "    x11-wm/xpra[?server]"
	elog "    || ( net-misc/nxclient net-misc/nx ) "
	elog "and net-dns/avahi[python] for automatic server discovery"
}
