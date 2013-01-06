# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cropgui/cropgui-0.1.1.ebuild,v 1.3 2012/12/28 16:41:41 ago Exp $

EAPI="4"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils python

DESCRIPTION="GUI for lossless cropping of jpeg images"
HOMEPAGE="http://emergent.unpythonic.net/01248401946"
SRC_URI="http://media.unpythonic.net/emergent-files/01248401946/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/imaging
	dev-python/pygobject:2
	dev-python/pygtk:2
"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i  -e '/Encoding/d' \
		-e '/Version/d' \
		-e '/MimeType/s/$/&;/' \
		-e '/Categories/s/Application;//' \
		cropgui.desktop || die 'sed on cropgui.desktop failed'
}

src_install() {
	install_cropgui_wrapper() {
		insinto "$(python_get_sitedir)/${PN}"
		python_convert_shebangs -q ${PYTHON_ABI} *.py
		doins cropgtk.py cropgui_common.py filechooser.py cropgui.glade
		make_wrapper cropgui-${PYTHON_ABI} "$(PYTHON -a) $(python_get_sitedir)/${PN}/cropgtk.py"
	}
	python_execute_function -q install_cropgui_wrapper
	python_generate_wrapper_scripts "${ED}/usr/bin/cropgui"

	domenu cropgui.desktop
	doicon cropgui.png
}
