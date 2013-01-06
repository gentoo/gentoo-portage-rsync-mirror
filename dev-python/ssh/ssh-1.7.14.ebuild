# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ssh/ssh-1.7.14.ebuild,v 1.1 2012/05/10 17:11:39 neurogeek Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="http://pypi.python.org/pypi/ssh"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="doc examples"

RDEPEND=">=dev-python/pycrypto-2.1"
DEPEND="${RDEPEND}
		dev-python/setuptools"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py --verbose
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml docs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demos
	fi
}
