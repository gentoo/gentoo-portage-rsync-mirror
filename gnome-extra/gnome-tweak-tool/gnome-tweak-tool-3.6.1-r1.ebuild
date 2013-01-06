# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-tweak-tool/gnome-tweak-tool-3.6.1-r1.ebuild,v 1.6 2013/01/01 14:32:39 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils gnome2 python-r1

DESCRIPTION="Tool to customize GNOME 3 options"
HOMEPAGE="http://live.gnome.org/GnomeTweakTool"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"

COMMON_DEPEND="
	>=gnome-base/gsettings-desktop-schemas-3.4
	>=dev-python/pygobject-3.2.1:3[${PYTHON_USEDEP}]
	gnome-base/gconf:2
"
# g-s-d, gnome-desktop, gnome-shell etc. needed at runtime for the gsettings schemas
RDEPEND="${COMMON_DEPEND}
	gnome-base/gconf:2[introspection]
	>=gnome-base/gnome-desktop-3.6.0.1:3=[introspection]
	x11-libs/gtk+:3[introspection]

	>=gnome-base/gnome-settings-daemon-3
	gnome-base/gnome-shell
	>=gnome-base/nautilus-3
	x11-wm/metacity
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_prepare() {
	# Add contents of Gentoo's cursor theme directory to cursor theme list
	epatch "${FILESDIR}/${PN}-3.0.4-gentoo-cursor-themes.patch"

	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	python_foreach_impl run_in_build_dir gnome2_src_configure
}

src_compile() {
	python_foreach_impl run_in_build_dir gnome2_src_compile
}

src_test() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	install_python() {
		gnome2_src_install
		python_doscript gnome-tweak-tool || die
	}
	python_foreach_impl run_in_build_dir install_python
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null || die
	"$@"
	popd > /dev/null
}
