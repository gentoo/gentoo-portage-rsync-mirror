# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/parassign/parassign-20130522.ebuild,v 1.1 2013/05/22 11:12:33 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 python-r1

DESCRIPTION="Assign protein nuclei solely on the basis of pseudocontact shifts (PCS)"
HOMEPAGE="http://protchem.lic.leidenuniv.nl/software/parassign/registration"
SRC_URI="PARAssign_Linux_x64_86.tgz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/cython
	dev-python/matplotlib
	dev-python/numpy
	dev-python/scientificpython
	sci-biology/biopython
	sci-libs/scipy"

S="${WORKDIR}"/PARAssign_Linux_x64_86/

src_prepare() {
	sed \
		-e '1i#!/usr/bin/python2' \
		-i code/*py || die

	if use x86; then
		sed \
			-e "s:munkres64:munkres:g" \
			-i modules/setup.py || die
	elif use amd64; then
		sed \
			-e "s:munkres:munkres64:g" \
			-i code/*py || die
	fi
	cd modules || die
	rm *o *c || die
	distutils-r1_src_prepare
}

src_compile() {
	cd modules || die
	distutils-r1_src_compile
}

src_install() {
	python_parallel_foreach_impl python_doscript code/* || die

	dodoc PARAssign_Tutorial.pdf README

	cd modules || die
	distutils-r1_src_install
}
