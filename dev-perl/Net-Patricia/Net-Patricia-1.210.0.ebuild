# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Patricia/Net-Patricia-1.210.0.ebuild,v 1.2 2013/12/08 13:03:34 zlogene Exp $

EAPI=4

MODULE_AUTHOR=GRUBER
MODULE_VERSION=1.21
inherit perl-module toolchain-funcs

DESCRIPTION="Patricia Trie perl module for fast IP address lookups"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="ipv6"

RDEPEND="dev-perl/Net-CIDR-Lite
	ipv6? (
		dev-perl/Socket6
	)
"
DEPEND="${RDEPEND}"

src_compile() {
	emake AR="$(tc-getAR)" OTHERLDFLAGS="${LDFLAGS}"
}

#SRC_TEST="do"
