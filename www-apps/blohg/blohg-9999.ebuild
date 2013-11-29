# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/blohg/blohg-9999.ebuild,v 1.18 2013/11/29 03:54:22 rafaelmartins Exp $

EAPI=5

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"
DISTUTILS_SRC_TEST="setup.py"

GIT_ECLASS=""
if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="git://github.com/rafaelmartins/blohg.git
		https://github.com/rafaelmartins/blohg"
fi

inherit distutils ${GIT_ECLASS}

DESCRIPTION="A Mercurial (or Git) based blogging engine."
HOMEPAGE="http://blohg.org/ http://pypi.python.org/pypi/blohg"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc git +mercurial test"

REQUIRED_USE="|| ( git mercurial )
	test? ( git mercurial )"

RDEPEND="=dev-python/docutils-0.10*
	>=dev-python/flask-0.10.1
	>=dev-python/flask-babel-0.7
	>=dev-python/flask-script-0.5.3
	>=dev-python/frozen-flask-0.7
	>=dev-python/jinja-2.5.2
	dev-python/pyyaml
	dev-python/setuptools
	dev-python/pygments
	git? ( =dev-python/pygit2-0.20* )
	mercurial? ( >=dev-vcs/mercurial-1.6 )"

DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? ( dev-python/mock )"

src_prepare() {
	if ! use git; then
		rm -rf blohg/vcs_backends/git || die 'rm failed'
	fi

	if ! use mercurial; then
		rm -rf blohg/vcs_backends/hg || die 'rm failed'
	fi

	distutils_src_prepare
}

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
