# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-imlib2/kaa-imlib2-0.2.3-r2.ebuild,v 1.2 2014/08/10 21:12:56 slyfox Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Imlib2 wrapper for Python"
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-python/kaa-base-0.3.0[${PYTHON_USEDEP}]
	dev-libs/libxml2[python]
	media-libs/imlib2"
RDEPEND="${DEPEND}"
DISTUTILS_IN_SOURCE_BUILD=1

PATCHES=( "${FILESDIR}/kaa-imlib2-remove-png-dep.patch" )
