# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/zsi/zsi-2.1_alpha1.ebuild,v 1.11 2013/08/03 09:45:47 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

MY_PN="ZSI"
MY_P="${MY_PN}-${PV/_alpha/-a}"

DESCRIPTION="Web Services for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/zsi.html"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc examples twisted"

DEPEND="dev-python/setuptools
	twisted? (
		dev-python/twisted-core
		dev-python/twisted-web
	)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES README"
PYTHON_MODNAME="${MY_PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	if ! use twisted; then
		sed -i \
			-e "/version_info/d"\
			-e "/ZSI.twisted/d"\
			setup.py || die "sed failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/*.{html,css,png}
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r doc/examples/* samples/*
	fi
}
