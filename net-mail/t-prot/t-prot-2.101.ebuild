# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/t-prot/t-prot-2.101.ebuild,v 1.5 2013/01/12 08:30:18 ulm Exp $

EAPI=2

inherit eutils

DESCRIPTION="TOFU protection - display filter for RFC822 messages"
HOMEPAGE="http://www.escape.de/~tolot/mutt/"
SRC_URI="http://www.escape.de/~tolot/mutt/t-prot/downloads/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Locale-gettext
	virtual/perl-Getopt-Long"

src_prepare() {
	epatch "${S}"/contrib/t-prot-r1.*-mutt*.diff
}

src_install() {
	dobin t-prot || die "dobin failed"
	doman t-prot.1 || die "doman failed"
	dodoc ChangeLog README TODO || die "dodoc failed"
	docinto contrib
	dodoc contrib/{README.examples,{muttrc,mailcap,nailrc}.t-prot*,t-prot.sl*,filter_innd.pl} \
		|| die "dodoc contrib failed"
}
