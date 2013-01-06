# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgilog/wsgilog-0.3.ebuild,v 1.1 2012/12/22 11:56:52 hwoarang Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="3.*"
inherit eutils distutils

DESCRIPTION="Class for logging in WSGI-applications"
HOMEPAGE="http://pypi.python.org/pypi/wsgilog/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="PKG-INFO"
PYTHON_PACKAGE="wsgilog"
