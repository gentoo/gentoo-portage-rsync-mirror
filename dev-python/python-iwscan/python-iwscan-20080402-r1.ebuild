# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-iwscan/python-iwscan-20080402-r1.ebuild,v 1.4 2014/01/14 15:08:35 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="A Python extension for iwscan access"
HOMEPAGE="http://projects.otaku42.de/browser/python-iwscan"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND="net-wireless/wireless-tools"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-wireless-tools-30.patch"
)

python_configure_all() {
	append-flags -fno-strict-aliasing
}
