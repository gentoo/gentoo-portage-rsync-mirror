# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpoison/arpoison-0.6-r2.ebuild,v 1.5 2012/12/28 11:20:02 ago Exp $

EAPI="5"

inherit toolchain-funcs

DESCRIPTION="A utility to poison ARP caches"
HOMEPAGE="http://arpoison.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""

RDEPEND=">=net-libs/libnet-1.1.0"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_prepare() {
	# respect CFLAGS, LDFLAGS and compiler, bug #337896
	# fix for crosscompilation, bug #375655
	sed -i Makefile \
		-e 's|gcc \(-Wall\)|$(CC) \1 $(CFLAGS) $(LDFLAGS)|' \
		-e "s|libnet-config|${ROOT}usr/bin/libnet-config|g" \
		|| die "sed on Makefile failed"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dosbin arpoison
	doman arpoison.8
	dodoc README TODO
}
