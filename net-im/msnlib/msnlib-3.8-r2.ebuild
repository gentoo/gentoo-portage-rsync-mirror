# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.8-r2.ebuild,v 1.1 2015/03/05 08:52:52 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1
PYTHON_REQ_USE="tk"

inherit distutils-r1 multilib

DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://blitiri.com.ar/p/msnlib/"
SRC_URI="http://blitiri.com.ar/p/${PN}/files/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="tk"

DEPEND=""
RDEPEND=""

pkg_setup() {
	python-single-r1_pkg_setup
}

python_prepare() {
	distutils-r1_python_prepare
	python_fix_shebang msn utils/msntk
}

python_install_all() {
	local DOCS=( README msnrc.sample )
	distutils-r1_python_install_all
}

python_install() {
	distutils-r1_python_install
	dobin msnsetup
	python_doscript msn
	use tk && python_doscript utils/msntk
}
