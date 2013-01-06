# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygit2/pygit2-0.17.3.ebuild,v 1.2 2012/10/04 22:40:23 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils vcs-snapshot

DESCRIPTION="Python bindings for libgit2"
HOMEPAGE="https://github.com/libgit2/pygit2"
SRC_URI="https://github.com/libgit2/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-libs/libgit2-0.17*"
DEPEND="${RDEPEND}"
