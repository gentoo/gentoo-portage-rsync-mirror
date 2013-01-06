# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lltag/lltag-0.14.2.ebuild,v 1.4 2009/06/11 13:42:11 fauli Exp $

inherit eutils perl-module

DESCRIPTION="Automatic command-line mp3/ogg/flac file tagger and renamer"
HOMEPAGE="http://home.gna.org/lltag"
SRC_URI="http://download.gna.org/lltag/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="mp3 ogg flac readline"

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	mp3? ( || ( media-sound/mp3info dev-perl/MP3-Tag ) )
	ogg? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	readline? ( dev-perl/Term-ReadLine-Perl )"
DEPEND="${RDEPEND}"

src_unpack() {
	perl-module_src_unpack
	epatch "${FILESDIR}"/${P}-manpage.patch
}

src_compile() {
	emake PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}/" PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor DOCDIR=/usr/share/doc/${P} install \
	install-doc install-man || die "emake install failed"
	fixlocalpod
	dodoc Changes
}
