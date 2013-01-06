# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/podcatcher/podcatcher-3.1.4.ebuild,v 1.2 2009/06/06 09:26:21 ssuominen Exp $

DESCRIPTION="Podcast client for the command-line written in Ruby."
HOMEPAGE="http://podcatcher.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/43722/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bittorrent"

RDEPEND=">=dev-lang/ruby-1.8.2
	bittorrent? ( dev-ruby/rubytorrent )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	dobin bin/podcatcher || die "dobin failed"
	dodoc demo/*
}
