# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyasn1-modules/pyasn1-modules-0.0.5.ebuild,v 1.9 2014/03/12 10:02:51 ago Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="pyasn1 modules"
HOMEPAGE="http://pyasn1.sourceforge.net/ http://pypi.python.org/pypi/pyasn1-modules"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

RDEPEND="dev-python/pyasn1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES README"
PYTHON_MODNAME="pyasn1_modules"

src_test() {
	echoit() { echo "$@"; "$@"; }
	testing() {
		local exit_status=0 test
		for test in test/*.sh; do
			PATH="${S}/tools:${PATH}" PYTHONPATH="build-${PYTHON_ABI}/lib" \
				echoit sh "${test}" || exit_status=1
		done
		return ${exit_status}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/tools
	doins tools/* || die "doins failed"
}
