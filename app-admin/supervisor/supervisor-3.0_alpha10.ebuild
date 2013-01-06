# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/supervisor/supervisor-3.0_alpha10.ebuild,v 1.3 2012/12/07 19:10:36 ulm Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml(+)"
SUPPORT_PYTHON_ABIS="1"
# xml.etree.ElementTree module required.
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

MY_PV="${PV/_alpha/a}"

DESCRIPTION="A system for controlling process state under UNIX"
HOMEPAGE="http://supervisord.org/ http://pypi.python.org/pypi/supervisor"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="repoze ZPL BSD HPND GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/meld3
	dev-python/setuptools"
DEPEND="${RDEPEND}
	test? ( dev-python/mock )"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS="CHANGES.txt README.txt TODO.txt"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/3.0_alpha8-no-docs.patch"
}

src_install() {
	distutils_src_install
	newinitd "${FILESDIR}/init.d" supervisord || die "newinitd failed"
	newconfd "${FILESDIR}/conf.d" supervisord || die "newconfd failed"
}
