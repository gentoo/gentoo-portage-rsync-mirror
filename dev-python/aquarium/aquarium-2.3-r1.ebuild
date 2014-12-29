# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aquarium/aquarium-2.3-r1.ebuild,v 1.1 2014/12/29 01:20:38 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Aquarium web application framework"
HOMEPAGE="http://aquarium.sourceforge.net/ http://pypi.python.org/pypi/aquarium"
SRC_URI="mirror://sourceforge/aquarium/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/cheetah[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
