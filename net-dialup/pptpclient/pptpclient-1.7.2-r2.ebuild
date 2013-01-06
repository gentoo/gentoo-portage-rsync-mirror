# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpclient/pptpclient-1.7.2-r2.ebuild,v 1.3 2010/04/29 19:46:17 truedfx Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P=${P/client}
MY_CMD=pptp-command-20050401

DESCRIPTION="Linux client for PPTP"
HOMEPAGE="http://pptpclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/pptpclient/${MY_P}.tar.gz
	mirror://gentoo/${MY_CMD}.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="tk"

DEPEND="net-dialup/ppp
	dev-lang/perl
	tk? ( dev-perl/perl-tk )"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

RESTRICT="test" #make test is useless and vector_test.c is broken

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-process-name.patch
	epatch "${FILESDIR}"/${P}-ip-path.patch
}

src_compile() {
	emake OPTIMISE= DEBUG= CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog DEVELOPERS NEWS README TODO USING
	dodoc Documentation/*
	dodir /etc/pptp.d

	# The current version of pptp-linux doesn't include the
	# RH-specific portions, so include them ourselves.
	newsbin "${WORKDIR}/${MY_CMD}" pptp-command
	dosbin "${FILESDIR}/pptp_fe.pl"
	use tk && dosbin "${FILESDIR}/xpptp_fe.pl"
}
