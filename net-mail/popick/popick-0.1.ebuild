# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/popick/popick-0.1.ebuild,v 1.6 2013/08/10 14:57:11 ago Exp $

inherit eutils

DESCRIPTION="A POP3 mailbox deleter that allows you to interactively specify regular expressions to match the message headers, and delete matching messages."
HOMEPAGE="http://www.topfx.com"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/Curses-UI
	virtual/perl-Getopt-Long"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv popick.pl popick || die "Renaming popick.pl to popick"
	sed -i -e 's:/usr/local:/usr:g' $(grep -rl /usr/local *) || die "sed /usr/local failed"
}

src_compile() {
	# No compiling needed :)
	pod2man popick > popick.1 || die "Generating manpage failed"
}

src_install() {
	dobin popick
	doman popick.1
}
