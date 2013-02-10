# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-2.0.ebuild,v 1.1 2013/02/10 21:01:21 hwoarang Exp $

EAPI=5
PLOCALES="ar ca ca_ES da de_DE el en es es_AR es_ES fi fi_FI fr gl he_IL hr hu
ia id it jv ka_GE nb nl nn pl pl_PL pt pt_BR ro ru sk sl sq sr sv_SE tr
uk_UA zh_CN"

inherit l10n qt4-r2

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gstreamer kde"

DEPEND=">=x11-libs/qt-gui-4.6:4[accessibility,gtkstyle]
	>=x11-libs/qt-dbus-4.6:4
	kde? ( || ( media-libs/phonon[gstreamer?] >=x11-libs/qt-phonon-4.6:4 ) )
	!kde? ( || ( >=x11-libs/qt-phonon-4.6:4 media-libs/phonon[gstreamer?] ) )
	gstreamer? (
		media-plugins/gst-plugins-soup:0.10
		media-plugins/gst-plugins-ffmpeg:0.10
		media-plugins/gst-plugins-faac:0.10
		media-plugins/gst-plugins-faad:0.10
	)
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

DOCS="AUTHORS CHANGES TODO"

#455976
PATCHES=( "${FILESDIR}"/${P}-disable-updates.patch )

src_prepare() {
	qt4-r2_src_prepare

	# Remove unneeded translations
	local trans=
	for x in $(l10n_get_locales); do
		trans+="${x}.ts "
	done
	if [[ -n ${trans} ]]; then
		sed -i -e "/^TRANSLATIONS/s/+=.*/+=${trans}/" locale/locale.pri || die
	fi
	# gcc-4.7. Bug #422977. Will probably be fixed
	# once ubuntu moves to gcc-4.7
	epatch "${FILESDIR}"/${PN}-1.9-gcc47.patch
}

src_install() {
	qt4-r2_src_install
	newicon images/app.png minitube.png
}
