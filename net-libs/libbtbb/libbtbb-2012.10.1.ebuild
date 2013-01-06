# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libbtbb/libbtbb-2012.10.1.ebuild,v 1.1 2012/10/08 19:01:54 zerochaos Exp $

EAPI=4

inherit multilib cmake-utils

DESCRIPTION="A library to decode Bluetooth baseband packets"
HOMEPAGE="http://libbtbb.sourceforge.net/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.code.sf.net/p/libbtbb/code"
	SRC_URI=""
	inherit git-2
	KEYWORDS=""
else
	MY_P=${P/\./-}
	MY_P=${MY_P/./-R}
	S=${WORKDIR}/${MY_P}
	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+wireshark"

RDEPEND="
	wireshark? (
		dev-libs/glib
		>=net-analyzer/wireshark-1.8.3-r1
	)
"
DEPEND="${RDEPEND}
	wireshark? ( virtual/pkgconfig )"

get_PV() { local pv=$(best_version "$1"); pv=${pv#"$1-"}; echo "${pv%-r[0-9]*}"; }

CMAKE_USE_DIR="${S}"/wireshark/plugins/btbb

src_prepare() {
		sed -i \
			-e '/set(CMAKE_INSTALL_LIBDIR/ d' \
			-e "s:R} N:R}/wireshark/plugins/$(get_PV net-analyzer/wireshark) N:" \
			${CMAKE_USE_DIR}/CMakeLists.txt || die
}

src_compile() {
	default_src_compile
	use wireshark && cmake-utils_src_compile
}

src_install() {
	dodir /usr/$(get_libdir)
	dodir /usr/include
	emake LDCONFIG=true DESTDIR="${D}" INSTALL_DIR="${ED}/usr/$(get_libdir)" INCLUDE_DIR="${ED}/usr/include" install

	use wireshark && cmake-utils_src_install
}
