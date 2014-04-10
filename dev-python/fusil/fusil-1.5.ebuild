# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fusil/fusil-1.5.ebuild,v 1.1 2014/04/10 07:52:53 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy2_0 pypy )

inherit distutils-r1 user

DESCRIPTION="Fusil the fuzzer is a Python library used to write fuzzing programs."
HOMEPAGE="http://bitbucket.org/haypo/fusil/wiki/Home http://pypi.python.org/pypi/fusil"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=">=dev-python/python-ptrace-0.6[${PYTHON_USEDEP}]
	doc? ( dev-python/docutils[${PYTHON_USEDEP}] )"

RDEPEND="${DEPEND}"

python_compile_all() {
	use doc && emake -C doc RST2HTML="rst2html.py" || die "Generation of documentation failed"
}

python_install_all(){
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	enewgroup fusil
	enewuser fusil -1 -1 -1 "fusil"
}
