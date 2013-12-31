# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/github-pages-publish/github-pages-publish-0.1.1.ebuild,v 1.1 2013/12/31 15:22:27 rafaelmartins Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

GIT_ECLASS=
if [[ ${PV} = *9999* ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="git://github.com/rafaelmartins/github-pages-publish.git
		https://github.com/rafaelmartins/github-pages-publish.git"
fi

inherit distutils-r1 ${GIT_ECLASS}

DESCRIPTION="A script that commits files from a directory to Github Pages."
HOMEPAGE="https://pypi.python.org/pypi/github-pages-publish
	https://github.com/rafaelmartins/github-pages-publish"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-python/pygit2-0.20.0
	virtual/python-argparse"
RDEPEND="${DEPEND}"
