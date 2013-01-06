# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.8-r1.ebuild,v 1.4 2012/09/14 14:16:05 scarabeus Exp $

EAPI="2"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit multilib distutils

DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://blitiri.com.ar/p/msnlib/"
SRC_URI="http://blitiri.com.ar/p/${PN}/files/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="tk"

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="msncb.py msnlib.py"

src_prepare() {
	distutils_src_prepare
	python_convert_shebangs 2 msn utils/msntk
}

src_install() {
	distutils_src_install

	dodoc doc/* || die "dodoc failed"
	dobin {msn,msnsetup} || die
	use tk && { dobin utils/msntk || die; }

	insinto /usr/share/doc/${PF}
	doins msnrc.sample || die
}
