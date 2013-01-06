# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tleds/tleds-1.05_beta11-r2.ebuild,v 1.1 2010/09/19 00:12:14 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P/eta11/}"
DESCRIPTION="Blinks keyboard LEDs indicating outgoing and incoming network packets on selected network interface"
HOMEPAGE="http://www.hut.fi/~jlohikos/tleds_orig.html"
SRC_URI="http://www.hut.fi/~jlohikos/tleds/public/${MY_P/11/10}.tgz
	http://www.hut.fi/~jlohikos/tleds/public/${MY_P}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="X"

DEPEND="X? ( >=x11-libs/libX11-1.0.0 )"
RDEPEND="${DEPEND}"

src_unpack() {
	# unpack only original sources, not patches
	unpack tleds-1.05beta10.tgz
}

src_prepare() {
	# code patches
	epatch \
		"${DISTDIR}"/${MY_P}.patch.bz2 \
		"${FILESDIR}"/${P}-gentoo.patch

	# respect CC/CFLAGS/LDFLAGS, new X11 prefix
	local opts="$(echo '$(GCCOPTS)')"
	sed -i Makefile \
		-e 's:-O3 -Wall:$(CFLAGS) $(LDFLAGS) -Wall:' \
		-e 's:gcc \($(GCCOPTS)\):$(CC) \1:' \
		-e 's:gcc \(-DNO_X_SUPPORT\):$(CC) \1:' \
		-e 's:/usr/X11R6:/usr:g' \
		|| die "sed failed in Makefile"
}

src_compile() {
	if use X ; then
		emake CC=$(tc-getCC) all || die "make failed"
	else
		emake CC=$(tc-getCC) tleds || die "make tleds failed"
	fi
}

src_install() {
	dosbin tleds
	use X && dosbin xtleds

	doman tleds.1
	dodoc README Changes

	newinitd "${FILESDIR}"/tleds.init.d tleds
	newconfd "${FILESDIR}"/tleds.conf.d tleds
}
