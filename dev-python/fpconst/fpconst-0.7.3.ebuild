# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fpconst/fpconst-0.7.3.ebuild,v 1.18 2012/05/13 20:17:37 aballier Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python Module for handling IEEE 754 floating point special values"
HOMEPAGE="http://chaco.bst.rochester.edu:8080/statcomp/projects/RStatServer/fpconst/ http://pypi.python.org/pypi/fpconst http://sourceforge.net/projects/rsoap/files/"
SRC_URI="mirror://sourceforge/rsoap/${P}.tar.gz"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="pep-0754.txt"
PYTHON_MODNAME="fpconst.py"
