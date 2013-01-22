# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colander/colander-1.0_alpha1.ebuild,v 1.1 2013/01/22 07:01:30 patrick Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6 3:3.2"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.0 3.1"
DISTUTILS_SRC_TEST=nosetests

inherit distutils

DESCRIPTION="A simple schema-based serialization and deserialization library"
HOMEPAGE="http://docs.pylonsproject.org/projects/colander/en/latest/ http://pypi.python.org/pypi/colander"
MY_P=${P/_alpha1/a1}
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

# MIT license is used by included (modified) iso8601.py code.
LICENSE="repoze MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# Depend on an ebuild of translationstring with Python 3 support.
RDEPEND=">=dev-python/translationstring-1.1"

DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

# Include COPYRIGHT.txt because the license seems to require it.
DOCS="CHANGES.txt COPYRIGHT.txt README.txt"

src_prepare() {
	distutils_src_prepare

	# Remove pylons theme since it's not included in source
	sed -e "/# Add and use Pylons theme/,+37d" -i docs/conf.py || die
}

src_compile() {
	distutils_src_compile

	if use doc; then
		# https://github.com/Pylons/colander/issues/38
		PYTHONPATH="." emake -C docs html SPHINXOPTS=""
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
