# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/rsvndump/rsvndump-0.5.4.ebuild,v 1.1 2011/02/14 17:28:17 sping Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Dump a remote Subversion repository"
HOMEPAGE="http://rsvndump.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-vcs/subversion
	dev-libs/apr
	sys-devel/gettext"
DEPEND="${RDEPEND}
	doc? ( app-text/xmlto
		>=app-text/asciidoc-8.4 )"

src_configure() {
	econf $(use_enable doc man)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS || die "dodoc failed"
}
