# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pip/pip-1.5.6.ebuild,v 1.12 2015/03/07 00:21:59 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3  )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Installs python packages -- replacement for easy_install"
HOMEPAGE="http://www.pip-installer.org/ http://pypi.python.org/pypi/pip/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE=""

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

# required test data isn't bundled with the tarball
RESTRICT="test"

python_install_all() {
	local DOCS=( AUTHORS.txt docs/*.rst )
	distutils-r1_python_install_all

	COMPLETION="${T}"/completion.tmp

	${EPYTHON} pip/runner.py completion --bash > "${COMPLETION}" || die
	newbashcomp "${COMPLETION}" ${PN}

	${EPYTHON} pip/runner.py completion --zsh > "${COMPLETION}" || die
	insinto /usr/share/zsh/site-functions
	newins "${COMPLETION}" _pip
}
