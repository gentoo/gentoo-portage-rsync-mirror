# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/coinor-mp/coinor-mp-1.7.6.ebuild,v 1.4 2014/02/04 08:50:46 jlec Exp $

EAPI=5

inherit autotools-utils multilib

MYPN=CoinMP

DESCRIPTION="COIN-OR lightweight API for COIN-OR libraries CLP, CBC, and CGL"
HOMEPAGE="https://projects.coin-or.org/CoinMP/"
SRC_URI="http://www.coin-or.org/download/source/${MYPN}/${MYPN}-${PV}.tgz"

LICENSE="EPL-1.0"
SLOT="0/1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples static-libs"

RDEPEND="sci-libs/coinor-cbc:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MYPN}-${PV}/${MYPN}"

src_prepare() {
	sed -i \
		-e '/addlibsdir/s/$(DESTDIR)//' \
		Makefile.in || die
	sed -i \
		-e "s:lib/pkgconfig:$(get_libdir)/pkgconfig:g" \
		configure || die
	autotools-utils_src_prepare
}

src_configure() {
	# needed for the --with-coin-instdir
	dodir /usr
	local myeconfargs=(
		--enable-dependency-linking
		--with-coin-instdir="${ED}"/usr
	)
	autotools-utils_src_configure
}

src_test() {
	autotools-utils_src_test test
}

src_install() {
	autotools-utils_src_install
	# already installed
	rm "${ED}"/usr/share/coin/doc/${MYPN}/{README,AUTHORS,LICENSE} || die
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
