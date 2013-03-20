# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycparser/pycparser-2.09.1.ebuild,v 1.2 2013/03/20 08:03:38 idella4 Exp $

EAPI="5"
# 3.3 not supported due to nose lacking support
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy{1_9,2_0} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="C parser and AST generator written in Python"
HOMEPAGE="https://bitbucket.org/eliben/pycparser/"
SRC_URI="https://bitbucket.org/eliben/${PN}/get/release_v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/ply[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests || die
}
