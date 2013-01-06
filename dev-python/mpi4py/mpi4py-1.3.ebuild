# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpi4py/mpi4py-1.3.ebuild,v 1.4 2012/08/02 17:20:52 bicatali Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="Message Passing Interface for Python"
HOMEPAGE="http://code.google.com/p/mpi4py/ http://pypi.python.org/pypi/mpi4py"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

DEPEND="virtual/mpi"
RDEPEND="${DEPEND}"

src_prepare() {
	# not needed on install
	rm -r docs/source || die
}

src_test() {
	local exclude
	has_version virtual/mpi[romio] || exclude="--exclude=file --exclude=class"
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			mpiexec -n 2 "$(PYTHON)" test/runtests.py ${exclude}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r demo/*
	fi
}
