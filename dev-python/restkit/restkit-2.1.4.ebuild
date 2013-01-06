# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/restkit/restkit-2.1.4.ebuild,v 1.2 2010/10/17 21:57:10 arfrever Exp $

EAPI=3

# tests currently broken
#DISTUTILS_SRC_TEST="nosetests"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3*"

inherit distutils

TAG="benoitc-restkit-addf4be"

DESCRIPTION="A HTTP ressource kit for Python."
HOMEPAGE="http://github.com/benoitc/restkit http://benoitc.github.com/restkit/ http://pypi.python.org/pypi/restkit"
SRC_URI="http://github.com/benoitc/restkit/tarball/${PV}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cli doc examples"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx
		dev-python/epydoc )"
RDEPEND="cli? ( dev-python/ipython
	dev-python/setuptools )"

DOCS="NOTICE README.rst TODO.txt doc/*.rst"

S="${WORKDIR}/${TAG}"

# TODO
# - optionally depend on gevent and/or eventlet

src_compile() {
	distutils_src_compile

	if use doc ; then
		cd doc
		emake html || die "building docs failed"
	fi
}

src_install() {
	distutils_src_install

	use cli || rm "${D}"/usr/bin/restcli*

	use doc && dohtml -r doc/_build/html/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
