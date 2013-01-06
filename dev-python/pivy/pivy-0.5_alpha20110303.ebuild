# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pivy/pivy-0.5_alpha20110303.ebuild,v 1.7 2012/12/26 14:44:59 jlec Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Coin3d binding for Python"
HOMEPAGE="http://pivy.coin3d.org/"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/coin
	>=media-libs/SoQt-1.5.0"
DEPEND="${RDEPEND}
	dev-lang/swig"
