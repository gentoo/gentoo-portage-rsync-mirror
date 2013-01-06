# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nsat/nsat-1.5-r1.ebuild,v 1.4 2012/10/06 19:00:44 pinkbyte Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Network Security Analysis Tool, an application-level network security scanner"
HOMEPAGE="http://nsat.sourceforge.net/"
SRC_URI="mirror://sourceforge/nsat/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="X"

RDEPEND="X? ( x11-libs/libX11
		dev-lang/tk )
	net-libs/libpcap"

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch
	# bug 128204
	epatch "${FILESDIR}"/${P}-lvalue-gcc4.patch
	epatch "${FILESDIR}"/${P}-strip.patch
	# bug 389767
	use amd64 && epatch "${FILESDIR}"/${P}-amd64-compat.patch

	# Respect LDFLAGS
	sed -i -e '/..\/nsat/,+1s/${CFLAGS}/${CFLAGS} ${LDFLAGS}/' \
		src/Makefile.in  || die 'first sed for respecting LDFLAGS failed'
	sed -i -e '/@$(CC)/s/$(CFLAGS)/$(CFLAGS) $(LDFLAGS)/' \
		src/smb/Makefile.in || die 'second sed for respecting LDFLAGS failed'

	sed -i "s:^#CGIFile /usr/local/share/nsat/nsat.cgi$:#CGIFile /usr/share/nsat/nsat.cgi:g" \
		nsat.conf || die "sed on nsat.conf failed"
	sed -i "s:/usr/local:/usr:g" Makefile.in || die "sed on Makefile.in failed"
	sed -i "s:/usr/local:/usr:g" tools/xnsat || die "sed on tools/xnsat failed"
	sed -i -e "s:/usr/local/share/nsat/nsat.conf:/etc/nsat/nsat.conf:g" \
		-e "s:/usr/local/share/nsat/nsat.cgi:/usr/share/nsat/nsat.cgi:g" \
		src/lang.h || die "sed on src/lang.h failed"

	eautoreconf
}

src_configure() {
	econf $(use_with X x) || die "configuration failed"
}

src_compile() {
	make|| die "compile problem"
}

src_install () {
	dobin nsat smb-ns
	use X && dobin tools/xnsat

	insinto /usr/share/nsat
	doins nsat.cgi

	insinto /etc/nsat
	doins nsat.conf

	dodoc README doc/CHANGES
	doman doc/nsat.8
}
