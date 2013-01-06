# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gaupol/gaupol-0.17.1.ebuild,v 1.2 2011/02/13 10:51:20 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils fdo-mime gnome2-utils versionator

MAJOR_MINOR_VERSION="$(get_version_component_range 1-2)"

DESCRIPTION="Gaupol is a subtitle editor for text-based subtitles"
HOMEPAGE="http://home.gna.org/gaupol"
SRC_URI="http://download.gna.org/${PN}/${MAJOR_MINOR_VERSION}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="spell"

RDEPEND="dev-python/chardet
	>=dev-python/pygtk-2.16
	spell? (
		app-text/iso-codes
		>=dev-python/pyenchant-1.4
	)"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog CREDITS NEWS TODO README"
PYTHON_MODNAME="aeidon gaupol"

src_compile() {
	addpredict /root/.gconf
	addpredict /root/.gconfd
	distutils_src_compile
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	elog "Previewing support needs MPlayer or VLC."

	if use spell; then
		elog "Additionally, spell-checking requires a dictionary, any of"
		elog "Aspell/Pspell, Ispell, MySpell, Uspell, Hspell or AppleSpell."
	fi
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
