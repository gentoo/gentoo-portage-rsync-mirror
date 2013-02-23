# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/w3mir/w3mir-1.0.10-r1.ebuild,v 1.6 2013/02/23 20:29:32 zmedico Exp $

inherit perl-app eutils

DESCRIPTION="w3mir is a all purpose HTTP copying and mirroring tool"
SRC_URI="http://langfeldt.net/w3mir/${P}.tar.gz"
HOMEPAGE="http://langfeldt.net/w3mir/"
IUSE=""

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ppc ~sparc x86 ~arm-linux ~x86-linux"

DEPEND="${DEPEND}
	>=dev-perl/URI-1.0.9
	>=dev-perl/libwww-perl-5.64-r1
	>=virtual/perl-MIME-Base64-2.12"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-cwd.diff"
}
