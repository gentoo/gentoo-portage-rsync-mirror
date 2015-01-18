# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qbs/qbs-1.3.3.ebuild,v 1.1 2015/01/18 04:05:08 pesa Exp $

EAPI=5

inherit multilib pax-utils qmake-utils

DESCRIPTION="Qt Build Suite"
HOMEPAGE="http://qt-project.org/wiki/qbs"
SRC_URI="http://download.qt.io/official_releases/${PN}/${PV}/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc qt5 test"

RDEPEND="
	!qt5? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtscript:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtscript:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
	)
"
DEPEND="${RDEPEND}
	doc? (
		!qt5? ( dev-qt/qthelp:4 )
		qt5? ( dev-qt/qdoc:5 dev-qt/qthelp:5 )
	)
	test? (
		!qt5? (
			dev-qt/qtdeclarative:4
			dev-qt/qttest:4
		)
		qt5? (
			dev-qt/qtdeclarative:5
			dev-qt/qttest:5
		)
	)
"

src_prepare() {
	# fix plugins libdir
	sed -i -e "/destdirPrefix/ s:/lib:/$(get_libdir):" \
		src/plugins/plugins.pri || die

	# disable tests that require nodejs (bug 527652)
	sed -i -e 's/!haveNodeJs()/true/' \
		tests/auto/blackbox/tst_blackbox.cpp || die

	if ! use test; then
		sed -i -e '/SUBDIRS = auto/d' \
			tests/tests.pro || die
	fi
}

src_configure() {
	local myqmakeargs=(
		qbs.pro # bug 523218
		-recursive
		CONFIG+=disable_rpath
		QBS_INSTALL_PREFIX="${EPREFIX}/usr"
		QBS_LIBRARY_DIRNAME="$(get_libdir)"
	)

	if use qt5; then
		eqmake5 "${myqmakeargs[@]}"
	else
		eqmake4 "${myqmakeargs[@]}"
	fi
}

src_compile() {
	default

	# disable mprotect wrt bug 526664
	pax-mark m "${S}"/bin/qbs{,-config,-config-ui}
}

src_test() {
	# disable mprotect wrt bug 526664
	pax-mark m "${S}"/bin/tst_*

	einfo "Setting up test environment in ${T}"

	export HOME=${T}
	export LD_LIBRARY_PATH=${S}/$(get_libdir)

	local qmakepath=${EROOT}usr/$(get_libdir)/$(usev qt5 || echo qt4)/bin/qmake
	[[ -x ${qmakepath} ]] || qmakepath=${EROOT}usr/bin/qmake

	"${S}"/bin/qbs-setup-toolchains "${EROOT}usr/bin/gcc" gcc || die
	"${S}"/bin/qbs-setup-qt "${qmakepath}" qbs_autotests || die

	einfo "Running autotests"
	default
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	# install documentation
	if use doc; then
		emake docs
		dodoc -r doc/html
		dodoc doc/qbs.qch
		docompress -x /usr/share/doc/${PF}/qbs.qch
	fi
}
