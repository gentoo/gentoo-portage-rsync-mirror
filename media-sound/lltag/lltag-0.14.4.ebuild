# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lltag/lltag-0.14.4.ebuild,v 1.2 2011/08/06 19:13:59 sping Exp $

EAPI=2
inherit perl-module

DESCRIPTION="Automatic command-line mp3/ogg/flac file tagger and renamer"
HOMEPAGE="http://home.gna.org/lltag"
SRC_URI="http://download.gna.org/lltag/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac mp3 ogg readline"

RDEPEND="dev-lang/perl
	dev-perl/libwww-perl
	mp3? ( media-sound/mp3info dev-perl/MP3-Tag )
	ogg? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	readline? ( dev-perl/Term-ReadLine-Perl )"
DEPEND="${RDEPEND}"

pkg_setup() {
	mylltagopts=(
		"DESTDIR=${D}"
		"PREFIX=/usr"
		"SYSCONFDIR=/etc"
		"MANDIR=/usr/share/man"
		"PERL_INSTALLDIRS=vendor"
		"DOCDIR=/usr/share/doc/${PF}"
		)
}

src_compile() {
	emake "${mylltagopts[@]}" || die
}

src_install() {
	emake "${mylltagopts[@]}" install{,-doc,-man} || die
	dodoc Changes
	fixlocalpod
}
