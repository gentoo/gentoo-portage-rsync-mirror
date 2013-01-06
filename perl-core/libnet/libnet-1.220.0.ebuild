# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/libnet/libnet-1.220.0.ebuild,v 1.3 2012/05/05 23:47:13 aballier Exp $

EAPI=3

MODULE_AUTHOR=GBARR
MODULE_VERSION=1.22
inherit eutils perl-module

DESCRIPTION="A URI Perl Module"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="sasl"

RDEPEND="sasl? ( dev-perl/Authen-SASL )"
DEPEND=""

SRC_TEST="do"

src_prepare() {
	cp "${FILESDIR}"/libnet.cfg "${S}"
	epatch "${FILESDIR}"/1.22-hostname.patch
}
