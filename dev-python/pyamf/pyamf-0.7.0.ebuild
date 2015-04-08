# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyamf/pyamf-0.7.0.ebuild,v 1.1 2015/02/10 18:27:29 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=PyAMF
MY_P=${MY_PN}-${PV}

DESCRIPTION="Action Message Format (AMF) support for Python"
HOMEPAGE="https://github.com/hydralabs/pyamf"
SRC_URI="https://github.com/hydralabs/pyamf/releases/download/v${PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}

python_test() {
	esetup.py test
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "PyAMF optionally integrates with several third-party libraries"
		elog "and web frameworks. See the README or the Optional Extras section at"
		elog "https://github.com/hydralabs/pyamf/blob/master/doc/install.rst"
	fi
}
