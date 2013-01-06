# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kup/kup-0.3.2.ebuild,v 1.2 2012/04/13 16:42:33 gregkh Exp $

DESCRIPTION="kernel.org uploader tool"
HOMEPAGE="http://www.kernel.org/pub/software/network/kup"
SRC_URI="mirror://kernel/software/network/kup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
         dev-perl/Config-Simple"

src_install () {
	dobin kup
	dobin gpg-sign-all
	dobin kup-server
	doman kup.1
	dodoc README COPYING
}
