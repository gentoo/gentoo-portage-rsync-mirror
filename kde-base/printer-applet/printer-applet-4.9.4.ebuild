# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/printer-applet/printer-applet-4.9.4.ebuild,v 1.2 2012/12/22 16:28:31 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
PYTHON_DEPEND="2"
inherit python kde4-base

DESCRIPTION="KDE printer system tray utility"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	>=app-admin/system-config-printer-common-1.2.2
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}"

pkg_setup() {
	kde4-base_pkg_setup
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	kde4-base_src_prepare

	# Rename printer-applet -> printer-applet-kde
	local newname="printer-applet-kde"
	sed -e "/PYKDE4_ADD_EXECUTABLE/s/ printer-applet[[:space:]]*)/ ${newname})/" \
		-e "/install/s/)/ RENAME ${newname}.desktop)/" \
		-i CMakeLists.txt || die "failed to rename printer-applet executable"
	sed -e "/Exec/s/printer-applet/${newname}/" \
		-i printer-applet.desktop || die "failed to patch .desktop file"
}

src_install() {
	kde4-base_src_install
	python_convert_shebangs -q -r $(python_get_version) "${ED}"
}

pkg_postrm() {
	python_mod_cleanup "${PREFIX}share/apps/${PN}"
}
