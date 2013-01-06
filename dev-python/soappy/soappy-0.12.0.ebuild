# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soappy/soappy-0.12.0.ebuild,v 1.19 2010/10/30 23:46:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

MY_PN="SOAPpy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SOAP implementation for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"
LICENSE="BSD"
IUSE="examples ssl"

DEPEND=">=dev-python/fpconst-0.7.1
		dev-python/pyxml"
RDEPEND="${DEPEND}
		ssl? ( dev-python/m2crypto )"

S="${WORKDIR}/${MY_P}"

DOCS="RELEASE_INFO"
PYTHON_MODNAME="${MY_PN}"

pkg_setup() {
	python_pkg_setup

	if use ssl && ! has_version "=dev-lang/python-2*[ssl]"; then
		ewarn "The 'ssl' USE-flag is enabled, but dev-lang/python is"
		ewarn "not compiled with it. You'll only get server-side SSL support."
		ewarn "Just emerge dev-lang/python afterwards with the ssl USE-flag to"
		ewarn "get client-side encryption."
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-python-2.5-compat.patch"
}

src_install() {
	distutils_src_install
	dodoc docs/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r bid contrib tools validate
	fi
}
