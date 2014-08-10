# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/linklint/linklint-2.3.5.ebuild,v 1.7 2014/08/10 21:28:30 slyfox Exp $

DESCRIPTION="a Perl program that checks links on web sites"
HOMEPAGE="http://www.linklint.org/"
SRC_URI="http://www.linklint.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	exeinto /usr/bin
	newexe ${P} linklint || die
	dodoc INSTALL.unix INSTALL.windows LICENSE.txt READ_ME.txt CHANGES.txt
	dohtml doc/*
}
