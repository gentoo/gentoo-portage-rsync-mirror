# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rain/rain-1.2.9_beta1.ebuild,v 1.2 2010/09/15 16:29:47 jer Exp $

EAPI="2"

inherit autotools eutils

MY_P=${P/_/}
MY_P=${MY_P/-/_}
DESCRIPTION="powerful tool for testing stability of hardware and software utilizing IP protocols"
HOMEPAGE="http://www.mirrors.wiretapped.net/security/packet-construction/rain/"
SRC_URI="
	mirror://ubuntu/pool/universe/r/${PN}/${MY_P}.orig.tar.gz
	mirror://ubuntu/pool/universe/r/${PN}/${MY_P}-1.diff.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P/_/-}"

src_prepare() {
	# Debian patch
	epatch "${WORKDIR}"/${MY_P}-1.diff

	# respect CFLAGS, LDFLAGS, correct man path
	sed -i Makefile.in \
		-e 's|-g|@CFLAGS@|' \
		-e 's|/usr/local/man|/usr/share/man|g' \
		-e 's|^SBINDIR=|&/usr|g' \
		-e 's|$(CC) -o|$(CC) $(CFLAGS) $(LDFLAGS) -o|g' \
		|| die "sed Makefile.in"

	# generate a new configure that respects/exports CC
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install"
	dodoc BUGS CHANGES README TODO
}
