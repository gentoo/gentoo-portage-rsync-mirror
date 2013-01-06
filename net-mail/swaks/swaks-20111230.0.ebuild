# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/swaks/swaks-20111230.0.ebuild,v 1.1 2012/02/09 11:44:32 eras Exp $

DESCRIPTION="Swiss Army Knife SMTP; Command line SMTP testing, including TLS and AUTH"
HOMEPAGE="http://www.jetmore.org/john/code/swaks"
SRC_URI="http://www.jetmore.org/john/code/swaks/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="ssl"

DEPEND=">=dev-lang/perl-5.8.8"

RDEPEND="${DEPEND}
		>=dev-perl/Net-DNS-0.65
		ssl? ( >=dev-perl/Net-SSLeay-1.35 )
		>=virtual/perl-MIME-Base64-3.07
		>=virtual/perl-Digest-MD5-2.39
		>=virtual/perl-Time-HiRes-1.97
		>=virtual/perl-Time-Local-1.19
		>=dev-perl/Authen-NTLM-1.02
		>=dev-perl/Authen-DigestMD5-0.04
		>=dev-perl/Digest-SHA1-2.11"

src_compile() {
	/usr/bin/pod2man -s 1 doc/ref.pod swaks.1 || die "man page compulation failed"
}

src_install() {
	newbin swaks swaks || die "newbin failed"
	doman swaks.1 || die
	dodoc README doc/*.txt || die
}
