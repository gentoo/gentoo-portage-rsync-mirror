# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hgsubversion/hgsubversion-1.5.ebuild,v 1.1 2013/06/17 10:14:45 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="hgsubversion is a Mercurial extension for working with Subversion repositories."
HOMEPAGE="https://bitbucket.org/durin42/hgsubversion/wiki/Home http://pypi.python.org/pypi/hgsubversion"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-vcs/mercurial-1.4[${PYTHON_USEDEP}]
	|| (
		dev-python/subvertpy[${PYTHON_USEDEP}]
		>=dev-vcs/subversion-1.5[python]
	)"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

DOCS=( README )

python_prepare_all() {
	# https://bitbucket.org/durin42/hgsubversion/issue/390/latest-release-missing-invalid_utf8targz
	# Still no response, faile imported to files to fix tests
	cp -r "${FILESDIR}"/invalid_utf8.tar.gz tests/fixtures/ || die "deded"
}

python_test() {
	"${PYTHON}" tests/run.py || die "Tests failed under ${EPYTHON}"
}
