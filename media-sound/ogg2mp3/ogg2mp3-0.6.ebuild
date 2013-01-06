# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogg2mp3/ogg2mp3-0.6.ebuild,v 1.3 2009/07/09 16:55:04 ssuominen Exp $

EAPI=2

DESCRIPTION="A perl script to convert Ogg Vorbis files to MP3 files."
HOMEPAGE="http://www.jamesa.com/projects/ogg2mp3/"
SRC_URI="http://www.jamesa.com/projects/ogg2mp3/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-sound/lame
	dev-perl/String-ShellQuote
	media-sound/vorbis-tools[ogg123]"
DEPEND=""

src_install() {
	dobin ogg2mp3 || die "dobin failed"
	dodoc doc/{AUTHORS,ChangeLog,README,TODO}
}
