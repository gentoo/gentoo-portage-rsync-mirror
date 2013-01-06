# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astropy/astropy-0.1-r1.ebuild,v 1.3 2012/08/08 19:10:03 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST=setup.py
# configobj is restricted to 2.*
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

DESCRIPTION="Collection of common tools needed for performing astronomy and astrophysics"
HOMEPAGE="http://astropy.org/ https://github.com/astropy/astropy"
SRC_URI="http://github.com/downloads/${PN}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="dev-libs/expat
	dev-python/numpy
	!dev-python/pyfits
	!dev-python/vo"
DEPEND="${RDEPEND}
	dev-python/configobj
	dev-python/pytest
	doc? ( dev-python/sphinx dev-python/matplotlib )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	# Remove most of the bundled deps (expat,zlib)
	rm -rf cextern ${PN}/extern ${PN}/io/fits/src/{zlib,inffast,inftrees,trees}.{c,h}

	export ASTROPY_USE_SYSTEM_PYTEST=1
	epatch "${FILESDIR}"/${P}-expat.patch \
		"${FILESDIR}"/${P}-debundle_zlib.patch
	sed -e 's/from ..extern.configobj //g' \
		-i astropy/config/configuration.py || die

	# 422659
	sed -e 's/fitscheck/&_astropy/g' \
		-i ${PN}/io/fits/{scripts/fitscheck.py,hdu/base.py} \
		docs/io/fits/{appendix/faq.rst,appendix/history.rst} \
		scripts/fitscheck || die
	mv ${PN}/io/fits/scripts/fitscheck{,_${PN}}.py || die
	mv scripts/fitscheck{,_${PN}} || die

	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	if use doc; then
		PYTHONPATH=$(ls -d "${S}"/build-$(PYTHON -f --ABI)/lib*) emake html -C docs
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/_build/html/
}
