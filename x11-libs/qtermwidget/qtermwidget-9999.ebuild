# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qtermwidget/qtermwidget-9999.ebuild,v 1.4 2014/12/15 21:17:34 pesa Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit cmake-utils python-r1 git-r3

DESCRIPTION="Qt terminal emulator widget"
HOMEPAGE="https://github.com/qterminal/qtermwidget"
EGIT_REPO_URI="https://github.com/qterminal/qtermwidget.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="debug python qt5"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
	)
	!qt5? (
		dev-qt/designer:4
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use qt5)
		$(cmake-utils_use_build !qt5 DESIGNER_PLUGIN)
	)
	cmake-utils_src_configure

	# cmake-utils.eclass exports BUILD_DIR only after configure phase, so sed it here
	sed -i -e "/extra_lib_dirs/s@\.\.@${BUILD_DIR}@" pyqt4/config.py || die

	if use python; then
		configuration() {
			"${PYTHON}" config.py || die "${PYTHON} config.py failed"
		}
		BUILD_DIR="${S}/pyqt4" python_copy_sources
		BUILD_DIR="${S}/pyqt4" python_foreach_impl run_in_build_dir configuration
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use python; then
		BUILD_DIR="${S}/pyqt4" python_foreach_impl run_in_build_dir emake
	fi
}

src_install() {
	cmake-utils_src_install

	if use python; then
		BUILD_DIR="${S}/pyqt4" python_foreach_impl run_in_build_dir emake DESTDIR="${D}" install
		BUILD_DIR="${S}/pyqt4" python_foreach_impl python_optimize
	fi
}
