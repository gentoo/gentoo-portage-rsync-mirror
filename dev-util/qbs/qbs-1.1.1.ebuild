# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qbs/qbs-1.1.1.ebuild,v 1.1 2013/12/29 19:49:45 pesa Exp $

EAPI=5

inherit multilib qmake-utils

DESCRIPTION="Qt Build Suite"
HOMEPAGE="http://qt-project.org/wiki/qbs"
SRC_URI="http://download.qt-project.org/official_releases/${PN}/${PV}/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gui +qt4 qt5 test"

RDEPEND="
	qt4? (
		>=dev-qt/qtcore-4.8:4
		>=dev-qt/qtscript-4.8:4
		gui? ( >=dev-qt/qtgui-4.8:4 )
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtscript:5
		dev-qt/qtxml:5
		gui? ( dev-qt/qtwidgets:5 )
	)
"
DEPEND="${RDEPEND}
	doc? (
		qt4? ( >=dev-qt/qthelp-4.8:4 )
		qt5? ( dev-qt/qthelp:5 )
	)
	test? (
		qt4? ( >=dev-qt/qttest-4.8:4 )
		qt5? ( dev-qt/qttest:5 )
	)
"

REQUIRED_USE="^^ ( qt4 qt5 )"

S=${WORKDIR}/${P}.src

src_prepare() {
	# fix hardcoded libdir
	sed -i -e "s:/lib/qbs:/$(get_libdir)/qbs:" \
		src/lib/tools/preferences.cpp || die
	sed -i -e "/target\.path/ s:lib/:$(get_libdir)/:" \
		src/plugins/plugins.pri || die

	if ! use gui; then
		sed -i -e '/SUBDIRS += config-ui/d' \
			src/app/app.pro || die
	fi

	if ! use test; then
		sed -i -e '/SUBDIRS = auto/d' \
			tests/tests.pro || die
	fi
}

src_configure() {
	local myqmakeargs=(
		-recursive
		CONFIG+=disable_rpath
		QBS_INSTALL_PREFIX="${EPREFIX}/usr"
		QBS_LIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
	)

	if use qt4; then
		eqmake4 "${myqmakeargs[@]}"
	elif use qt5; then
		eqmake5 "${myqmakeargs[@]}"
	fi
}

src_test() {
	export HOME=${T}
	export LD_LIBRARY_PATH=${S}/lib

	einfo "Setting up test environment in ${T}"
	"${S}"/bin/qbs detect-toolchains || die
	"${S}"/bin/qbs setup-qt "${EROOT}"usr/bin/qmake qbs_autotests || die

	default
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	# install documentation
	if use doc; then
		emake docs
		dodoc doc/qbs.qch
		docompress -x /usr/share/doc/${PF}/qbs.qch
		dohtml -r doc/html/*
	fi
}
