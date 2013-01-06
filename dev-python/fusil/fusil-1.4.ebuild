# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fusil/fusil-1.4.ebuild,v 1.2 2012/06/07 20:29:52 zmedico Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"

inherit distutils eutils user

DESCRIPTION="Fusil the fuzzer is a Python library used to write fuzzing programs."
HOMEPAGE="http://bitbucket.org/haypo/fusil/wiki/Home http://pypi.python.org/pypi/fusil"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=">=dev-python/python-ptrace-0.6"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-python25.patch
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		emake RST2HTML="rst2html.py" || die "Generation of documentation failed"
	fi
}

src_install(){
	distutils_src_install
	if use doc; then
		dohtml doc/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	enewgroup fusil
	enewuser fusil -1 -1 -1 "fusil"
}
