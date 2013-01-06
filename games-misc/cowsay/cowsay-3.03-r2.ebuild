# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/cowsay/cowsay-3.03-r2.ebuild,v 1.10 2011/04/21 20:13:20 mr_bones_ Exp $

EAPI=2
inherit eutils

DESCRIPTION="configurable talking ASCII cow (and other characters)"
HOMEPAGE="http://www.nog.net/~tony/warez/cowsay.shtml"
SRC_URI="http://www.nog.net/~tony/warez/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/perl-5"

src_prepare() {
	sed	-i \
		-e '1 c\#!/usr/bin/perl'\
		-e 's/\$version/\$VERSION/g'\
		-e "s:%PREFIX%/share/cows:/usr/share/${P}/cows:" \
		-e '/getopts/ i\$Getopt::Std::STANDARD_HELP_VERSION=1;' cowsay \
			|| die "sed cowsay failed"
	sed -i \
		-e "s|%PREFIX%/share/cows|/usr/share/${P}/cows|" cowsay.1 \
			|| die "sed cowsay.1 failed"
	epatch \
		"${FILESDIR}/${P}"-tongue.patch \
		"${FILESDIR}/${P}"-mech.patch \
		"${FILESDIR}/${P}"-utf8.patch
}

src_install() {
	dobin cowsay || die "dobin failed"
	doman cowsay.1
	dosym cowsay /usr/bin/cowthink
	dosym cowsay.1 /usr/share/man/man1/cowthink.1
	dodir /usr/share/${P}/cows
	cp -r cows "${D}"/usr/share/${P}/ || die "cp failed"
}
