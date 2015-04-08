# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pivy/pivy-9999.ebuild,v 1.1 2013/04/27 12:02:32 xmw Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit mercurial distutils-r1

DESCRIPTION="Coin3d binding for Python"
HOMEPAGE="http://pivy.coin3d.org/"
EHG_REPO_URI="http://hg.sim.no/Pivy/default"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	media-libs/coin
	>=media-libs/SoQt-1.5.0"
DEPEND="${RDEPEND}
	dev-lang/swig"
