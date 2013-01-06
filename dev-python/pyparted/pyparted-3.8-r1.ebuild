# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparted/pyparted-3.8-r1.ebuild,v 1.10 2012/02/22 07:54:16 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython 2.7-pypy-*"
PYTHON_MODNAME="parted"

inherit distutils

DESCRIPTION="Python bindings for sys-block/parted"
HOMEPAGE="https://fedorahosted.org/pyparted/"
SRC_URI="https://fedorahosted.org/releases/p/y/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="test"

CDEPEND="
	dev-python/decorator
	>=sys-block/parted-3
	sys-libs/ncurses
"
DEPEND="
	${CDEPEND}
	test? ( dev-python/pychecker )
"
RDEPEND="${CDEPEND}"
