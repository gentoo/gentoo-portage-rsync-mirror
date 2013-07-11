# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gevent/gevent-1.0_rc2.ebuild,v 1.2 2013/07/11 21:21:28 vincent Exp $

EAPI=5

# py2.5 needs http://pypi.python.org/pypi/ssl
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="ssl"

inherit distutils-r1 flag-o-matic

MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Python networking library that uses greenlet to provide synchronous API"
HOMEPAGE="http://gevent.org/ http://pypi.python.org/pypi/gevent/"
SRC_URI="mirror://github/SiteSupport/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="doc examples"

RDEPEND="dev-libs/libev
	net-dns/c-ares
	dev-python/greenlet[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

# Tests take long and fail terribly a few times.
# It also seems that they require network access.
RESTRICT="test"

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	rm -rf {libev,c-ares}

	distutils-r1_python_prepare_all
}

python_configure_all() {
	append-flags -fno-strict-aliasing
}

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	cd greentest || die
	"${PYTHON}" testrunner.py || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )

	distutils-r1_python_install_all

	dodoc changelog.rst

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
