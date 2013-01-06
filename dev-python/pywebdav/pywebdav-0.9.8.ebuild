# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebdav/pywebdav-0.9.8.ebuild,v 1.1 2012/05/05 11:02:52 cedk Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P=${P/pywebdav/PyWebDAV}

DESCRIPTION="WebDAV server written in Python"
HOMEPAGE="http://code.google.com/p/pywebdav/ http://pypi.python.org/pypi/PyWebDAV"
SRC_URI="http://pywebdav.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="doc/ARCHITECTURE doc/Changes doc/TODO doc/interface_class doc/walker"
PYTHON_MODNAME="pywebdav"
