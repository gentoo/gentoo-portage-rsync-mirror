# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/frescobaldi/frescobaldi-2.0.11.ebuild,v 1.1 2013/10/17 03:44:07 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 gnome2-utils

DESCRIPTION="A LilyPond sheet music text editor"
HOMEPAGE="http://www.frescobaldi.org/"
SRC_URI="https://github.com/wbsoft/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2 public-domain" # public-domain is for bundled Tango icons
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="portmidi"

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	dev-python/PyQt4[X,${PYTHON_USEDEP}]
	>=media-sound/lilypond-2.14.2
	portmidi? ( media-libs/portmidi )"
DEPEND="${RDEPEND}"

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
