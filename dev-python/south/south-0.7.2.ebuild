# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/south/south-0.7.2.ebuild,v 1.2 2011/02/13 10:49:08 betelgeuse Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Intelligent schema migrations for Django apps."
HOMEPAGE="http://south.aeracode.org/"
SRC_URI="http://www.aeracode.org/releases/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${PN}"

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake -C docs html || die "building docs failed"
	fi
}

src_install() {
	distutils_src_install

	use doc && dohtml -r docs/_build/html/*
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "In order to use the south schema migrations for your Django project,"
	elog "just add 'south' to your INSTALLED_APPS in the settings.py file."
	elog "manage.py will now automagically offer the new functions."
}
