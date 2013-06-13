# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozinfo/mozinfo-0.5.ebuild,v 1.1 2013/06/13 06:20:02 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="File for interface to transform introspected system information to a format pallatable to Mozilla"
HOMEPAGE="https://wiki.mozilla.org/Auto-tools http://pypi.python.org/pypi/mozinfo"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools
	dev-python/simplejson"
RDEPEND="${DEPEND}"
