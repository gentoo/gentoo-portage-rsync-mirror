# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-cpan/g-cpan-0.13.02.ebuild,v 1.8 2010/10/23 09:02:23 ssuominen Exp $

DESCRIPTION="g-cpan: generate and install CPAN modules using portage"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	dodir /usr/bin
	cp "${S}"/bin/g-cpan.pl "${D}"/usr/bin/
	dodir /usr/share/man/man1
	cp "${S}"/man/g-cpan.pl.1 "${S}"/man/g-cpan.1
	doman "${S}"/man/*
	dodoc Changes
	dosym /usr/bin/g-cpan.pl /usr/bin/g-cpan
}
