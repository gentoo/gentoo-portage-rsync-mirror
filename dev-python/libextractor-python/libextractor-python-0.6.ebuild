# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libextractor-python/libextractor-python-0.6.ebuild,v 1.1 2012/05/11 08:35:35 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="extractor.py"

inherit distutils

DESCRIPTION="A library used to extract metadata from files of arbitrary type"
HOMEPAGE="http://www.gnu.org/software/libextractor/"
SRC_URI="mirror://gnu/libextractor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libextractor-0.6.3"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/Extractor-${PV}
