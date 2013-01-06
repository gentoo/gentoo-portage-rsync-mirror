# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/profxp/profxp-3_pre2.ebuild,v 1.10 2006/02/13 14:54:33 mcummings Exp $

inherit perl-app

DESCRIPTION="FXP (server-to-server FTP) commandline client written in Perl"
HOMEPAGE="http://duncanthrax.net/profxp/"
SRC_URI="http://duncanthrax.net/profxp/profxp-v${PV/_/-}-src.tar.gz
	http://search.cpan.org/src/CLINTDW/SOCKS-0.03/lib/Net/SOCKS.pm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-Time-HiRes
	dev-perl/TermReadKey
	dev-perl/Term-ReadLine-Perl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack profxp-v${PV/_/-}-src.tar.gz
	cp ${DISTDIR}/SOCKS.pm ${S}/
	sed -i 's:/home/tom/ActivePerl-5\.6:/usr:' ${S}/profxpv3.pl
}

src_compile() { :; }

src_install() {
	perlinfo
	newbin profxpv3.pl profxp.pl
	dosym profxp.pl /usr/bin/profxp
	insinto ${ARCH_LIB}/Net
	doins SOCKS.pm
	insinto ${ARCH_LIB}/${PN}
	doins ${PN}/*.pm
}
