# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/2mandvd/2mandvd-1.8.1.ebuild,v 1.2 2012/08/02 20:29:40 pesa Exp $

EAPI=4
LANGS="cs de en it ru"

inherit eutils qt4-r2

MY_PN="2ManDVD"

DESCRIPTION="The successor of ManDVD"
HOMEPAGE="http://kde-apps.org/content/show.php?content=99450"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="media-libs/libsdl
	virtual/ffmpeg
	virtual/glu
	virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
"
RDEPEND="${DEPEND}
	|| ( app-cdr/cdrkit app-cdr/cdrtools )
	dev-lang/perl
	media-fonts/dejavu
	media-gfx/exif
	media-libs/netpbm
	media-sound/sox
	media-video/dvdauthor
	media-video/ffmpegthumbnailer
	media-video/mjpegtools
	media-video/mplayer[encode]
"

S="${WORKDIR}/${MY_PN}"

PATCHES=(
	"${FILESDIR}/${PN}-fix-const-char-concatenation.patch"
	"${FILESDIR}/${PN}-1.7.3-libav.patch"
)

src_prepare() {
	# Cleaning old backup files
	find . -name "*~" -delete || die

	for file in *.cpp; do
		# Fix path
		sed -e "s:qApp->applicationDirPath().\?+.\?\":\"/usr/share/${PN}:g" -i "${file}" || die "sed failed"
		sed -e "s:qApp->applicationDirPath():\"/usr/share/${PN}/\":g" -i "${file}" || die "sed failed"
	done

	# We'll make a newbin called ${PN} so we need to change references to the old "2ManDVD" (${MY_PN}).
	# Sed is more flexible than a patch.
	sed -e "s:openargument.right(${#MY_PN}) != \"${MY_PN}\":openargument.right(${#PN}) != \"${PN}\":" \
		-e "s:openargument.right($(( ${#MY_PN} + 2 ))) != \"./${MY_PN}\":openargument.right($(( ${#PN} + 2 ))) != \"./${PN}\":" \
		-i mainfrm.cpp || die "sed failed"

	qt4-r2_src_prepare
}

src_install() {
	insinto /usr/share/${PN}

	# Data:
	doins -r Bibliotheque
	doins -r Interface

	doins fake.pl

	# Translations:
	for lang in ${LINGUAS}; do
		for x in ${LANGS}; do
			[[ ${lang} == ${x} ]] && doins ${PN}_${x}.qm
		done
	done
	[[ -z ${LINGUAS} ]] && doins ${PN}_en.qm

	# Doc:
	dodoc README.txt

	# Bin and menu entry:
	newbin 2ManDVD ${PN}
	doicon Interface/mandvd.png
	make_desktop_entry ${PN} ${MY_PN} mandvd "Qt;AudioVideo;Video"
}

pkg_postinst() {
	elog "You may wish to install media-video/xine-ui and/or build"
	elog "media-sound/sox with USE=mad for improved media handling support."
}
