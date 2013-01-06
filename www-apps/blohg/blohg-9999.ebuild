# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/blohg/blohg-9999.ebuild,v 1.13 2012/12/26 23:32:33 ottxor Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"
DISTUTILS_SRC_TEST="setup.py"

HG_ECLASS=""
if [[ ${PV} = *9999* ]]; then
	HG_ECLASS="mercurial"
	EHG_REPO_URI="http://hg.rafaelmartins.eng.br/blohg/"
fi

inherit distutils ${HG_ECLASS}

DESCRIPTION="A Mercurial-based blogging engine."
HOMEPAGE="http://blohg.org/ http://pypi.python.org/pypi/blohg"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc test"

CDEPEND=">=dev-python/docutils-0.8
	>=dev-python/flask-0.8
	>=dev-python/flask-babel-0.7
	>=dev-python/flask-script-0.3
	>=dev-python/frozen-flask-0.7
	>=dev-python/jinja-2.5.2
	>=dev-vcs/mercurial-1.6
	dev-python/pyyaml
	dev-python/setuptools
	dev-python/pygments"

DEPEND="${CDEPEND}
	doc? ( dev-python/sphinx )"

RDEPEND="${CDEPEND}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo 'building documentation'
		emake -C docs html
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		einfo 'installing documentation'
		dohtml -r docs/_build/html/*
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	local ver="${PV}"
	[[ ${PV} = *9999* ]] && ver="latest"

	elog "You may want to check the upgrade notes:"
	elog "http://docs.blohg.org/en/${ver}/upgrade/"
}
