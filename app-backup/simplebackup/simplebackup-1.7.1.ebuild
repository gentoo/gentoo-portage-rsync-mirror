# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/simplebackup/simplebackup-1.7.1.ebuild,v 1.1 2006/06/02 12:28:54 lisa Exp $

DESCRIPTION="Cross-platform backup program"
HOMEPAGE="http://migas.kicks-ass.org/index.php?pag=en.myapps&subpag=simplebackup"
SRC_URI="http://migas.kicks-ass.org/myapps/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="sasl"

DEPEND=""
RDEPEND="dev-lang/perl
	sasl? ( dev-perl/Authen-SASL )"

S=${WORKDIR}/${P}/unix

src_compile() {
	return;
}

src_install() {
	newbin simplebackup.pl simplebackup
	dodoc readme.html readme.txt
}
