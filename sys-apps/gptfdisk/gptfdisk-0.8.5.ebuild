# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gptfdisk/gptfdisk-0.8.5.ebuild,v 1.7 2013/02/23 19:52:18 ago Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="gdisk - GPT partition table manipulator for Linux"
HOMEPAGE="http://www.rodsbooks.com/gdisk/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="kernel_linux"

RDEPEND="dev-libs/icu
	dev-libs/popt
	>=sys-libs/ncurses-5.7-r7
	kernel_linux? ( sys-apps/util-linux )" # libuuid
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake CXX="$(tc-getCXX) $($(tc-getPKG_CONFIG) --variable=CXXFLAGS icu-io icu-uc) ${CXXFLAGS}" #439696
}

#src_test() {
#	./gdisk_test.sh || die
#}

src_install() {
	local app
	for app in gdisk sgdisk cgdisk fixparts; do
		dosbin ${app}
		doman ${app}.8
	done
	dodoc NEWS README
}
