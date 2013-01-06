# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/scmpc/scmpc-0.4.0.ebuild,v 1.4 2012/09/17 02:33:36 tomka Exp $

EAPI=4

DESCRIPTION="a client for MPD which submits your tracks to last.fm"
HOMEPAGE="http://cmende.github.com/scmpc/"
SRC_URI="mirror://github/cmende/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/confuse
	media-libs/libmpdclient
	net-misc/curl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README.md scmpc.conf.example )

src_install() {
	default

	newinitd "${FILESDIR}"/${PN}-2.init ${PN}
	insinto /etc
	insopts -m600
	newins scmpc.conf.example scmpc.conf
}
