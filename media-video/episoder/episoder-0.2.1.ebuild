# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/episoder/episoder-0.2.1.ebuild,v 1.3 2005/07/28 10:31:19 dholm Exp $

DESCRIPTION="episoder is a tool to tell you when new episodes of your favourite
TV shows are airing"
HOMEPAGE="http://www.desire.ch/tools/episoder/"
SRC_URI="http://tools.desire.ch/data/episoder/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="net-misc/wget"

src_install() {
	insinto /usr/share/${PN}/
	insopts -m755
	doins scripts/*sh
	doins plugins/*

	dobin scripts/episoder
	dodoc README examples/home.episoder CHANGELOG

	doman episoder.1
}
