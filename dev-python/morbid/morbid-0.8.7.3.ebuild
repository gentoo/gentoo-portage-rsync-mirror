# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/morbid/morbid-0.8.7.3.ebuild,v 1.5 2010/12/26 14:49:12 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A Twisted-based publish/subscribe messaging server that uses the STOMP protocol"
HOMEPAGE="http://pypi.python.org/pypi/morbid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="dev-python/stomper
	dev-python/twisted
	dev-python/twisted-web"
DEPEND="${RDEPEND}
	dev-python/setuptools"
