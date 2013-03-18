# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/zssh/zssh-1.5c-r1.ebuild,v 1.1 2013/03/18 08:22:44 pinkbyte Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="An ssh wrapper enabling zmodem up/download in ssh"
HOMEPAGE="http://zssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls readline"

DEPEND="readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}
	net-misc/openssh
	net-dialup/lrzsz"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.5a-gentoo-include.diff"
	epatch_user
}

src_configure() {
	tc-export AR CC RANLIB
	econf \
                $(use_enable nls) \
	        $(use_enable readline)
}

src_install() {
	dobin ${PN} ztelnet
	doman ${PN}.1 ztelnet.1
	dodoc CHANGES FAQ README TODO
}
