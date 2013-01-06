# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traffic-vis/traffic-vis-0.35-r2.ebuild,v 1.6 2012/11/21 04:38:10 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Generate traffic stats in html, ps, text and gif format"
HOMEPAGE="http://www.mindrot.org/traffic-vis.html"
SRC_URI="http://www.mindrot.org/files/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE="gif"
DEPEND="net-libs/libpcap
	gif? ( media-libs/netpbm
		app-text/ghostscript-gpl
		dev-lang/perl )
	=dev-libs/glib-1.2*"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-libpcap-header-fix.patch

	# bug 143930 - traffic-vis expects /usr/sbin/traffic-tops
	sed -i frontends/traffic-togif \
		-e "s:/usr/sbin/traffic-tops:/usr/bin/traffic-tops:g" \
		|| die "sed frontends/traffic-togif"
	# drop DEBUG flags
	sed -i -e "/^DEBUGFLAGS/d" Makefile || die
	tc-export CC
}

src_install() {
	dosbin collector/traffic-collector || die
	doman collector/traffic-collector.8 || die

	for mybin in $(use gif && echo frontends/traffic-togif) \
			frontends/traffic-tohtml \
			frontends/traffic-tops \
			frontends/traffic-totext \
			sort/traffic-sort \
			utils/traffic-exclude \
			utils/traffic-resolve ; do

		dobin ${mybin} || die
		doman ${mybin}.8 || die
	done

	newinitd "${FILESDIR}"/traffic-vis.init.d traffic-vis || die
	newconfd "${FILESDIR}"/traffic-vis.conf.d traffic-vis || die

	dodoc TODO README BUGS CHANGELOG || die
}
