# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cropgui/cropgui-0.1.1-r2.ebuild,v 1.1 2013/05/29 13:16:15 pinkbyte Exp $

EAPI="5"

PYTHON_COMPAT=( python2_{6,7} )
inherit eutils python-r1

DESCRIPTION="GUI for lossless cropping of jpeg images"
HOMEPAGE="http://emergent.unpythonic.net/01248401946"
SRC_URI="http://media.unpythonic.net/emergent-files/01248401946/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}
	dev-python/imaging[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i  -e '/Encoding/d' \
		-e '/Version/d' \
		-e '/MimeType/s/$/&;/' \
		-e '/Categories/s/Application;//' \
		cropgui.desktop || die 'sed on cropgui.desktop failed'
	# bug 471530
	epatch "${FILESDIR}/${P}-PIL.patch"

	epatch_user
}

install_cropgui_wrapper() {
	python_domodule cropgtk.py cropgui_common.py filechooser.py cropgui.glade
	make_wrapper "${PN}-${EPYTHON}" "${PYTHON} $(python_get_sitedir)/${PN}/cropgtk.py"
}

src_install() {
	local python_moduleroot="${PN}"
	python_foreach_impl install_cropgui_wrapper
	dosym python-exec /usr/bin/"${PN}"

	domenu "${PN}.desktop"
	doicon "${PN}.png"
}
