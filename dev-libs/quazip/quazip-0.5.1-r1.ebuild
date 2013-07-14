# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/quazip/quazip-0.5.1-r1.ebuild,v 1.10 2013/07/14 17:35:49 ago Exp $

EAPI=5

inherit multilib qt4-r2

DESCRIPTION="A simple C++ wrapper over Gilles Vollant's ZIP/UNZIP package"
HOMEPAGE="http://quazip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ppc ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	sys-libs/zlib[minizip]
	dev-qt/qtcore:4"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest )"

S="${WORKDIR}"/${P}

DOCS="NEWS.txt README.txt"
HTML_DOCS=( doc/html/. )

PATCHES=(
	"${FILESDIR}"/${PN}-0.4.4-zlib.patch
	"${FILESDIR}"/${P}-zlib.patch
	"${FILESDIR}"/${P}-prll.patch
)

src_prepare() {
	sed \
		-e "1i\PREFIX = \"${EPREFIX}/usr/\"" \
		-e "s:/lib$:/$(get_libdir):g" \
		-i ${PN}/${PN}.pro || die
	use test || sed -e 's:qztest::g' -i ${PN}.pro || die
	qt4-r2_src_prepare
}

src_test() {
	cd qztest || die
	LD_LIBRARY_PATH="${S}"/${PN} ./qztest || die
}

src_install() {
	insinto /usr/share/cmake/Modules
	doins FindQuaZip.cmake
	qt4-r2_src_install
}
