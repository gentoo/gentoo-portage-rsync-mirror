# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/picard/picard-1.2.ebuild,v 1.1 2013/05/20 15:26:44 aballier Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.6 3.*"

inherit eutils distutils

MY_P="${P/_/}"
DESCRIPTION="An improved rewrite/port of the Picard Tagger using Qt"
HOMEPAGE="http://musicbrainz.org/doc/PicardQt"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/picard/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+acoustid +cdda nls"

DEPEND="dev-python/PyQt4[X]
	media-libs/mutagen
	acoustid? ( media-libs/chromaprint[tools] )
	cdda? ( >=media-libs/libdiscid-0.1.1 )
	"
RDEPEND="${DEPEND}"

# doesn't work with ebuilds
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS.txt NEWS.txt"

src_compile() {
	distutils_src_compile $(use nls || echo "--disable-locales")
}

src_install() {
	distutils_src_install --disable-autoupdate --skip-build \
		$(use nls || echo "--disable-locales")

	doicon picard.ico
	domenu picard.desktop
}

pkg_postinst() {
	distutils_pkg_postinst
	echo
	ewarn "If you are upgrading Picard and it does not start"
	ewarn "try removing Picard's settings:"
	ewarn "	rm ~/.config/MusicBrainz/Picard.conf"
	elog
	elog "You should set the environment variable BROWSER to something like"
	elog "\"firefox '%s' &\" to let python know which browser to use."
}
