# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ruledispatch/ruledispatch-0.5_pre2306-r1.ebuild,v 1.5 2012/02/22 09:47:37 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils versionator

MY_PN="RuleDispatch"
MY_P="${MY_PN}-$(get_version_component_range 1-2)a0.dev-$(get_version_component_range 3-)"
MY_P="${MY_P/pre/r}"

DESCRIPTION="Rule-based Dispatching and Generic Functions"
HOMEPAGE="http://peak.telecommunity.com/"
# http://svn.eby-sarna.com/RuleDispatch/
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="|| ( PSF-2.4 ZPL )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-python/pyprotocols-1.0_pre2306"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_PN}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="dispatch"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}_as_syntax_fix.patch"
}
