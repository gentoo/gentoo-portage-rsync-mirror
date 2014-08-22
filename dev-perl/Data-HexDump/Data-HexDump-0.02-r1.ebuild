# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-HexDump/Data-HexDump-0.02-r1.ebuild,v 1.1 2014/08/22 17:46:19 axs Exp $

EAPI=5

MODULE_AUTHOR=FTASSIN
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Data::HexDump - A Simple Hexadecial Dumper"

SLOT="0"
KEYWORDS="amd64 ~hppa ~sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

src_unpack() {
		perl-module_src_unpack
}

src_prepare() {
		mv "${S}/hexdump" "${S}/hexdump.pl"
		sed -i "s:hexdump:hexdump.pl:" "${S}/Makefile.PL"
		sed -i "s:hexdump:hexdump.pl:" "${S}/MANIFEST"
		sed -i "s:hexdump:hexdump.pl:" "${S}/hexdump.pl"
}
