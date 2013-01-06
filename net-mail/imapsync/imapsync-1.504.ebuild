# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.504.ebuild,v 1.1 2012/09/08 08:24:24 radhermit Exp $

EAPI=4

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another"
HOMEPAGE="http://ks.lamiral.info/imapsync/"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tgz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/Digest-HMAC
	dev-perl/IO-Socket-SSL
	dev-perl/Mail-IMAPClient
	dev-perl/TermReadKey
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64"

RESTRICT="test"

src_prepare() {
	sed -i -e "s/^install: testp/install:/" \
		-e "/^DO_IT/,/^$/d" "${S}"/Makefile || die
}

src_compile() { : ; }
