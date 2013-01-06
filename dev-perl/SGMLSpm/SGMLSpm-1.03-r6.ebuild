# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SGMLSpm/SGMLSpm-1.03-r6.ebuild,v 1.12 2012/05/09 14:31:49 aballier Exp $

inherit eutils perl-module

MY_P="${P}ii"
S=${WORKDIR}/${PN}

DESCRIPTION="Perl library for parsing the output of nsgmls"
HOMEPAGE="http://search.cpan.org/author/DMEGG/SGMLSpm-1.03ii/"
SRC_URI="mirror://cpan/authors/id/D/DM/DMEGG/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"
mydoc="TODO BUGS"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/Makefile.PL "${S}"/Makefile.PL
	epatch "${FILESDIR}"/sgmlspl.patch
	mv "${S}"/sgmlspl{.pl,}
}
