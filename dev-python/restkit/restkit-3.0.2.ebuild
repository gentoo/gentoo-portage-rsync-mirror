# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/restkit/restkit-3.0.2.ebuild,v 1.2 2011/11/29 20:22:15 floppym Exp $

EAPI=3

DISTUTILS_SRC_TEST="nosetests"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="A HTTP ressource kit for Python."
HOMEPAGE="http://github.com/benoitc/restkit http://benoitc.github.com/restkit/ http://pypi.python.org/pypi/restkit"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cli doc examples"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx
		dev-python/epydoc )
	test? ( dev-python/webob )"
RDEPEND="cli? ( dev-python/ipython
	dev-python/setuptools )"

DOCS="NOTICE README.rst TODO.txt doc/*.rst"

# TODO
# - optionally depend on gevent and/or eventlet

src_compile() {
	distutils_src_compile

	if use doc ; then
		cd doc
		PYTHONPATH="${S}" emake html || die "building docs failed"
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
