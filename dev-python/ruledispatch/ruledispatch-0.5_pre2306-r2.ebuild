# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ruledispatch/ruledispatch-0.5_pre2306-r2.ebuild,v 1.1 2013/04/09 08:55:34 idella4 Exp $

EAPI="5"
# For now, only py2.7 handles _d_speedups.pyx
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils versionator flag-o-matic

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
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_PN}"

PATCHES=( "${FILESDIR}/${PN}_as_syntax_fix.patch" )

python_configure_all() {
	append-flags -fno-strict-aliasing
}

python_test() {
	esetup.py && einfo "Tests effective under python2.7" || die "Tests failed under ${EPYTHON}"
}
