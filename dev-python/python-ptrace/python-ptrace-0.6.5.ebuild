# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ptrace/python-ptrace-0.6.5.ebuild,v 1.1 2013/06/13 03:08:20 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes)."
HOMEPAGE="http://bitbucket.org/haypo/python-ptrace/ http://pypi.python.org/pypi/python-ptrace"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="dev-libs/distorm64"
RESTRICT_PYTHON_ABIS="2.4"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
PYTHON_MODNAME="ptrace"

src_prepare() {
	python_copy_sources

	conversion() {
		[[ "${PYTHON_ABI}" == 2.* ]] && return

		2to3-${PYTHON_ABI} -w . > /dev/null || die "2to3 failed"
		2to3-${PYTHON_ABI} -dw . > /dev/null || die "2to3 failed"
	}
	python_execute_function --action-message 'Applying patches for Python ${PYTHON_ABI}' --failure-message 'Applying patches for Python ${PYTHON_ABI} failed' -s conversion
}

src_install() {
	distutils_src_install

	if use examples; then
	   insinto usr/share/doc/${PF}/examples
	   doins examples/*
	fi
}
