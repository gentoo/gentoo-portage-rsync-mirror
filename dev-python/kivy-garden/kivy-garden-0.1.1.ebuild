# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kivy-garden/kivy-garden-0.1.1.ebuild,v 1.2 2015/04/02 18:22:30 mr_bones_ Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_1,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Kivys Garden tool to manage flowers"
HOMEPAGE="http://kivy-garden.github.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/requests
	dev-python/setuptools
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/garden-${PV}"

src_prepare() {
	epatch "${FILESDIR}/remove_bat.patch"
}
