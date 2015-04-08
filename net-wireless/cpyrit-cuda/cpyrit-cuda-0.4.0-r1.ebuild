# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/cpyrit-cuda/cpyrit-cuda-0.4.0-r1.ebuild,v 1.3 2015/03/28 07:33:11 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="A sub-package that adds CUDA-capability to Pyrit"
HOMEPAGE="http://code.google.com/p/pyrit/"
SRC_URI="http://pyrit.googlecode.com/files/cpyrit-cuda-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/openssl:=
	net-libs/libpcap
	dev-util/nvidia-cuda-toolkit"
RDEPEND="${DEPEND}"
PDEPEND="~net-wireless/pyrit-${PV}"

pkg_setup() {
	python-single-r1_pkg_setup
}
