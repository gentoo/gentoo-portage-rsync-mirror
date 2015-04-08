# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/buildutils/buildutils-0.3-r1.ebuild,v 1.6 2015/03/08 23:41:01 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Extensions for developing Python libraries and applications"
HOMEPAGE="http://buildutils.lesscode.org http://pypi.python.org/pypi/buildutils"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/pudge[$(python_gen_usedep python{2_6,2_7})] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND=""

python_prepare_all() {
	# Enable pudge command.
	epatch "${FILESDIR}/${P}-pudge_addcommand.patch"
	sed -e "s/buildutils.command.publish/buildutils.publish_command.publish/" \
		-i buildutils/test/test_publish.py || die "sed failed"
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		# ensure docs are built with py2
		if "${PYTHON}" -c "import pudge"; then
			"${PYTHON}" setup.py pudge || die "Generation of documentation failed"
		else
			die "Generation of documentation failed"
		fi
	fi
}

python_test() {
	py.test || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/html/. )
	distutils-r1_python_install_all
}
