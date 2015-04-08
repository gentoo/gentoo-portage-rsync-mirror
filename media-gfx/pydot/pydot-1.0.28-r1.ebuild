# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pydot/pydot-1.0.28-r1.ebuild,v 1.27 2014/03/31 21:08:05 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python interface to Graphviz's Dot language"
HOMEPAGE="http://code.google.com/p/pydot/ http://pypi.python.org/pypi/pydot"
SRC_URI="http://pydot.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="
	dev-python/pyparsing[${PYTHON_USEDEP}]
	media-gfx/graphviz"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.23-setup.patch
)
