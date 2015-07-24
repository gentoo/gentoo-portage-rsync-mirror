# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/suds-jurko/suds-jurko-0.6.ebuild,v 1.3 2015/07/24 04:50:57 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python3_4 )

inherit distutils-r1

DESCRIPTION="Lightweight SOAP client (Jurko's fork) (py3 support)"
HOMEPAGE="http://bitbucket.org/jurko/suds"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_prepare() {
	rm -R tests
}
