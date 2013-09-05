# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-gnupg/py-gnupg-0.3.2-r1.ebuild,v 1.2 2013/09/05 18:46:41 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_P="GnuPGInterface-${PV}"

DESCRIPTION="A Python module to interface with GnuPG."
HOMEPAGE="http://py-gnupg.sourceforge.net/"
SRC_URI="mirror://sourceforge/py-gnupg/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=">=app-crypt/gnupg-1.2.1-r1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_test() {
	"${PYTHON}" unittests.py || die "Tests fail with ${EPYTHON}"
}
