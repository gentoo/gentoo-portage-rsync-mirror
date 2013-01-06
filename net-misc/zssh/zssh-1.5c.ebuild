# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zssh/zssh-1.5c.ebuild,v 1.4 2011/05/11 23:17:27 xmw Exp $

inherit eutils

DESCRIPTION="An ssh wrapper enabling zmodem up/download in ssh"
HOMEPAGE="http://zssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/zssh/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE="readline nls"

DEPEND=""
RDEPEND="net-misc/openssh
	 net-dialup/lrzsz"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/zssh-1.5a-gentoo-include.diff
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable readline)
	emake || die
}

src_install() {
	dobin zssh ztelnet || die
	doman zssh.1 ztelnet.1 || die
	dodoc CHANGES FAQ README TODO || die
}
