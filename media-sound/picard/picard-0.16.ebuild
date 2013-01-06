# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/picard/picard-0.16.ebuild,v 1.1 2011/10/24 03:59:39 radhermit Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit eutils distutils

MY_P="${P/_/}"
DESCRIPTION="An improved rewrite/port of the Picard Tagger using Qt"
HOMEPAGE="http://musicbrainz.org/doc/PicardQt"
SRC_URI="
	http://ftp.musicbrainz.org/pub/musicbrainz/picard/${MY_P}.tar.gz
	coverart? ( http://dev.gentoo.org/~radhermit/distfiles/${PN}-0.15.1-coverart.py.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cdda coverart ffmpeg nls"

DEPEND="
	dev-python/PyQt4[X]
	media-libs/mutagen
	cdda? ( >=media-libs/libdiscid-0.1.1 )
	ffmpeg? (
		virtual/ffmpeg
		>=media-libs/libofa-0.9.2 )"
RDEPEND="${DEPEND}"

# doesn't work with ebuilds
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS.txt INSTALL.txt NEWS.txt"

pkg_setup() {
	if ! use ffmpeg; then
		ewarn "The 'ffmpeg' USE flag is disabled. Acoustic fingerprinting and"
		ewarn "recognition will not be available."
	fi
	if ! use cdda; then
		ewarn "The 'cdda' USE flag is disabled. CD index lookup and"
		ewarn "identification will not be available. You can get audio CD support"
		ewarn "by installing media-libs/libdiscid."
	fi
}

src_unpack() {
	unpack ${A}
	if use coverart; then
		cp "${WORKDIR}"/${PN}-0.15.1-coverart.py "${S}"/${PN}/plugins/coverart.py || die "Copy of coverart plugin failed"
	fi
}

src_prepare() {
	distutils_src_prepare
}

src_configure() {
	$(PYTHON -f) setup.py config || die "setup.py config failed"
	if ! use ffmpeg; then
		sed -i -e "s:\(^with-avcodec\ =\ \).*:\1False:" \
			-e "s:\(^with-libofa\ =\ \).*:\1False:" \
			build.cfg || die "sed failed"
	fi
}

src_compile() {
	distutils_src_compile $(use nls || echo "--disable-locales")
}

src_install() {
	distutils_src_install --disable-autoupdate --skip-build \
		$(use nls || echo "--disable-locales")

	doicon picard.ico || die 'doicon failed'
	domenu picard.desktop || die 'domenu failed'
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
	if use coverart; then
		ewarn "You have downloaded and installed the coverart downloader plugin."
		ewarn "If you expect it to work please enable it in Options->Plugins."
	fi
}
