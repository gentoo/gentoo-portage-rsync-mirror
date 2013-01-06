# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-tastypie/django-tastypie-0.9.11-r1.ebuild,v 1.1 2012/05/08 12:23:05 iksaif Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="A flexible and capable API layer for django utilising serialisers"
HOMEPAGE="http://pypi.python.org/pypi/django-tastypie/ https://github.com/toastdriven/django-tastypie"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="bip doc digest lxml oauth yaml"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="tastypie"

RDEPEND=">=dev-python/mimeparse-0.1.3
	dev-python/python-dateutil
	bip? ( dev-python/biplist )
	digest? ( dev-python/python-digest )
	oauth? ( dev-python/oauth2 dev-python/django-oauth-plus )
	lxml? ( dev-python/lxml )
	yaml? ( dev-python/pyyaml )"
DEPEND="${RDEPEND} >=dev-python/django-1.2.5
	dev-python/setuptools"

src_compile() {
	if use doc; then
		emake -C docs html
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		docompress -x usr/share/doc/${PF}/doctrees
		dohtml -r docs/_build/html/
		insinto usr/share/doc/${PF}/doctrees
		doins -r docs/_build/doctrees/
	fi
}
