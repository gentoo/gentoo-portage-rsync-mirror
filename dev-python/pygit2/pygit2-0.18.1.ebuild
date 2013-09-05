# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygit2/pygit2-0.18.1.ebuild,v 1.2 2013/09/05 18:46:33 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Python bindings for libgit2"
HOMEPAGE="https://github.com/libgit2/pygit2"
SRC_URI="https://github.com/libgit2/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="=dev-libs/libgit2-0.18*"
DEPEND="${RDEPEND}"

python_test() {
	esetup.py test
}
