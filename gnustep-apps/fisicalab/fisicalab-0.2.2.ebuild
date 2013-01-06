# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/fisicalab/fisicalab-0.2.2.ebuild,v 1.1 2012/07/12 09:18:04 voyageur Exp $

EAPI=4
inherit gnustep-2

MY_P=FisicaLab-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="educational application to solve physics problems"
HOMEPAGE="http://www.nongnu.org/fisicalab"
SRC_URI="mirror://nongnu/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-libs/gsl-1.10
	>=virtual/gnustep-back-0.16.0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.1-as-needed.patch
}
