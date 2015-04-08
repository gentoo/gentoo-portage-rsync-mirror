# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egenix-mx-base/egenix-mx-base-3.2.4.ebuild,v 1.9 2012/12/08 15:52:06 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="eGenix utils for Python"
HOMEPAGE="http://www.egenix.com/products/python/mxBase http://pypi.python.org/pypi/egenix-mx-base"
SRC_URI="http://downloads.egenix.com/python/${P}.tar.gz"

LICENSE="eGenixPublic-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

PYTHON_MODNAME="mx"

src_prepare() {
	distutils_src_prepare

	# Don't install documentation in site-packages directories.
	sed -e "/\/Doc\//d" -i egenix_mx_base.py || die

	# Avoid unnecessary overriding of settings. Distutils in Gentoo is patched in better way.
	sed -e 's/if compiler.compiler_type == "unix":/if False:/' -i mxSetup.py || die
}

src_compile() {
	# mxSetup.py uses BASECFLAGS variable.
	BASECFLAGS="${CFLAGS}" distutils_src_compile
}

src_test() {
	testing() {
		local tst status=0
		for tst in $(find "build-${PYTHON_ABI}/" -name test.py)
		do
			PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)"	"$(PYTHON)" "${tst}" || status=1
		done
		return ${status}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	dohtml -a html -r mx
	insinto /usr/share/doc/${PF}
	find -iname "*.pdf" | xargs doins

	installation_of_headers() {
		local header
		dodir "$(python_get_includedir)/mx" || return 1
		while read -d $'\0' header; do
			mv -f "${header}" "${ED}$(python_get_includedir)/mx" || return 1
		done < <(find "${ED}$(python_get_sitedir)/mx" -type f -name "*.h" -print0)
	}
	python_execute_function -q installation_of_headers
}
