# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-freebsd/py-freebsd-0.9.3-r1.ebuild,v 1.4 2011/07/08 00:03:28 aballier Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Python interface to FreeBSD-specific system libraries"
HOMEPAGE="http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/py-freebsd/"
SRC_URI="mirror://freebsd/ports/local-distfiles/perky/${P}.tar.gz
	http://people.freebsd.org/~perky/distfiles/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND="sys-freebsd/freebsd-lib"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="freebsd_compat02.py"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/fbsd7-netstat.patch"
	epatch "${FILESDIR}/process-fix.patch"
	epatch "${FILESDIR}/freebsd8_patch-src-jail.c"
}

src_test() {
	testing() {
		local exit_status="0" test
		for test in test_kqueue.py test_sysctl.py; do
			if ! PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" tests/${test}; then
				eerror "${test} failed with $(python_get_implementation) $(python_get_version)"
				exit_status="1"
			fi
		done

		return "${exit_status}"
	}
	python_execute_function testing
}
