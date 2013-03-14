# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.3.4-r2.ebuild,v 1.3 2013/03/14 13:24:32 ago Exp $

EAPI="5"

inherit eutils autotools flag-o-matic

DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
HOMEPAGE="http://poptop.sourceforge.net/"
SRC_URI="mirror://sourceforge/poptop/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="tcpd gre-extreme-debug"

DEPEND="net-dialup/ppp
	tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-more-reodering-fixes.patch"

	#Match pptpd-logwtmp.so's version with pppd's version (#89895)
	local PPPD_VER=`best_version net-dialup/ppp`
	PPPD_VER=${PPPD_VER#*/*-} #reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER%%[_-]*} # main version without beta/pre/patch/revision
	sed -i -e "s:\\(#define[ \\t]*VERSION[ \\t]*\\)\".*\":\\1\"${PPPD_VER}\":" plugins/patchlevel.h || die
	sed -i -e "/^LDFLAGS/{s:=:+=:}" plugins/Makefile || die

	eautoreconf
}

src_configure() {
	use gre-extreme-debug && append-flags "-DLOG_DEBUG_GRE_ACCEPTING_PACKET"
	local myconf
	use tcpd && myconf="--with-libwrap"
	econf --enable-bcrelay \
		${myconf}
}

src_compile() {
	emake COPTS="${CFLAGS}"
}

src_install () {
	einstall

	insinto /etc
	doins samples/pptpd.conf

	insinto /etc/ppp
	doins samples/options.pptpd

	newinitd "${FILESDIR}/pptpd-init-r2" pptpd
	newconfd "${FILESDIR}/pptpd-confd" pptpd

	dodoc AUTHORS ChangeLog NEWS README* TODO
	docinto samples
	dodoc samples/*
}
