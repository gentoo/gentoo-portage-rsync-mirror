# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aquarium/aquarium-2.3.ebuild,v 1.3 2010/07/23 23:42:31 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Aquarium web application framework"
HOMEPAGE="http://aquarium.sourceforge.net/ http://pypi.python.org/pypi/aquarium"
SRC_URI="mirror://sourceforge/aquarium/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/cheetah"
RDEPEND="${DEPEND}"

DOCS="README TODO"
PYTHON_MODNAME="aquarium glass"
