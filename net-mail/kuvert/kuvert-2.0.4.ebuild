# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/kuvert/kuvert-2.0.4.ebuild,v 1.4 2011/11/25 23:35:56 hwoarang Exp $

EAPI=4
inherit toolchain-funcs

MY_P=${P/-/_}

DESCRIPTION="An MTA wrapper that automatically signs and/or encrypts
outgoing mail"
HOMEPAGE="http://www.snafu.priv.at/mystuff/kuvert/"
SRC_URI="http://www.snafu.priv.at/mystuff/kuvert/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc"
IUSE=""
SLOT="0"

S="${WORKDIR}/${PN}"

DEPEND=""
RDEPEND="app-crypt/gnupg
	sys-apps/keyutils
	dev-perl/MailTools
	dev-perl/MIME-tools
	dev-perl/Authen-SASL
	dev-perl/File-Slurp
	dev-perl/Net-Server-Mail
	perl-core/IO
	perl-core/File-Temp
	perl-core/Time-HiRes
	dev-lang/perl
	virtual/perl-libnet
	virtual/mta"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc dot-kuvert README THANKS TODO
}
