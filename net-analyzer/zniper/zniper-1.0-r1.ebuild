# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zniper/zniper-1.0-r1.ebuild,v 1.4 2012/12/26 18:59:46 jdhore Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Displays and kill active TCP connections seen by the selected interface."
HOMEPAGE="http://www.signedness.org/tools/"
SRC_URI="http://www.signedness.org/tools/zniper.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

S=${WORKDIR}/"zniper"

src_prepare() {
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		-e 's|@make|@$(MAKE)|g' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		linux_x86
}

src_install() {
	dobin zniper
	dodoc README
	doman zniper.1
}
