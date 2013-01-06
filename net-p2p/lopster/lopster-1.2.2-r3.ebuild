# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.2.2-r3.ebuild,v 1.6 2007/10/10 18:55:45 armin76 Exp $

inherit eutils autotools

IUSE="nls vorbis zlib flac"

DESCRIPTION="A Napster Client using GTK"
HOMEPAGE="http://lopster.sourceforge.net"
SRC_URI="mirror://sourceforge/lopster/${P}.tar.gz
	mirror://gentoo/${P}-bugfixes-4.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ~sparc x86"

RDEPEND="=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )
	zlib? ( sys-libs/zlib )
	flac? ( media-libs/flac )
	vorbis? ( >=media-libs/libvorbis-1.0 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}"/${P}-bugfixes-4.patch.bz2

	eautoreconf
}

src_compile() {
	econf \
		--with-pthread \
		$(use_enable nls) \
		$(use_with zlib) \
		$(use_with flac) \
		$(use_with vorbis ogg) || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS README ChangeLog NEWS TODO
}
