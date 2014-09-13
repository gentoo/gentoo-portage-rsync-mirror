# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qtermwidget/qtermwidget-9999.ebuild,v 1.2 2014/09/13 16:36:24 kensington Exp $

EAPI="5"

# Uncomment python related code when upstream updates their bindings

#PYTHON_COMPAT=( python2_7 python3_{2,3} )

inherit cmake-utils git-r3 #python-r1

DESCRIPTION="Qt4 terminal emulator widget"
HOMEPAGE="https://github.com/qterminal/"
EGIT_REPO_URI="git://github.com/qterminal/qtermwidget.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"
# python

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

#src_prepare() {
#	cmake-utils_src_prepare
#	sed \
#		-e 's/int scheme/const QString \&name/' \
#		-i pyqt4/qtermwidget.sip || die "sed qtermwidget.sip failed"
#}
#
#src_configure() {
#	cmake-utils_src_configure
#
#	# cmake-utils.eclass exports BUILD_DIR only after configure phase, so sed it here
#	sed \
#		-e "/extra_lib_dirs/s@\.\.@${BUILD_DIR}@" \
#		-e '/extra_libs/s/qtermwidget/qtermwidget4/' \
#		-i pyqt4/config.py || die "sed config.py failed"
#
#	configuration() {
#		${PYTHON} config.py || die "${PYTHON} config.py failed"
#	}
#	use python && BUILD_DIR="${S}/pyqt4" python_copy_sources
#	use python && BUILD_DIR="${S}/pyqt4" python_parallel_foreach_impl run_in_build_dir configuration || die "python configuration failed"
#}
#
#src_compile() {
#	cmake-utils_src_compile
#
#	use python && BUILD_DIR="${S}/pyqt4" python_parallel_foreach_impl run_in_build_dir emake || die "python compilation failed"
#}
#
#src_install() {
#	cmake-utils_src_install
#
#	use python && BUILD_DIR="${S}/pyqt4" python_parallel_foreach_impl run_in_build_dir emake DESTDIR="${D}" install || die "python installation failed"
#	use python && BUILD_DIR="${S}/pyqt4" python_parallel_foreach_impl python_optimize || die "python byte-compilation failed"
#}
