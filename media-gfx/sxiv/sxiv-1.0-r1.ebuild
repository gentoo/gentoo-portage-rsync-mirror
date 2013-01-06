# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sxiv/sxiv-1.0-r1.ebuild,v 1.1 2012/10/24 03:30:29 radhermit Exp $

EAPI=4

inherit eutils savedconfig toolchain-funcs

DESCRIPTION="Simple (or small or suckless) X Image Viewer"
HOMEPAGE="https://github.com/muennich/sxiv/"
SRC_URI="mirror://github/muennich/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/imlib2[X]
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	tc-export CC

	restore_config config.h
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
	dodoc README.md

	save_config config.h
}
