# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pelican/pelican-3.2.1.ebuild,v 1.1 2013/05/22 09:00:55 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A tool to generate a static blog, with restructured text (or markdown) input files."
HOMEPAGE="http://pelican.notmyidea.org/ http://pypi.python.org/pypi/pelican"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples markdown"

DEPEND="dev-python/feedgenerator[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/unidecode
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	markdown? ( dev-python/markdown[${PYTHON_USEDEP}] )
	virtual/python-argparse[${PYTHON_USEDEP}]"
RDEPEND=""

DOCS="README.rst"

python_install() {
	distutils-r1_python_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/* || die "failed to install examples"
	fi
}

# no tests: tests/content not in tarball for 2.8.1
# for 3.0, should be based on tox (refer to virtualenvwrapper)
