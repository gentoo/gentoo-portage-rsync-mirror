# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qt-creator/qt-creator-2.7.2.ebuild,v 1.2 2013/08/15 08:04:02 pesa Exp $

EAPI=5

PLOCALES="cs de es fr hu it ja pl ru sl uk zh_CN zh_TW"

inherit eutils l10n multilib qt4-r2

DESCRIPTION="Lightweight IDE for C++/QML development centering around Qt"
HOMEPAGE="http://qt-project.org/wiki/Category:Tools::QtCreator"
LICENSE="LGPL-2.1"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git
		https://git.gitorious.org/${PN}/${PN}.git"
else
	MY_PV=${PV/_/-}
	MY_P=${PN}-${MY_PV}-src
	[[ ${MY_PV} == ${PV} ]] && MY_REL=official || MY_REL=development
	SRC_URI="http://download.qt-project.org/${MY_REL}_releases/${PN/-}/${PV%.*}/${MY_PV}/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
fi

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"

QTC_PLUGINS=(android autotools:autotoolsprojectmanager bazaar
	clearcase cmake:cmakeprojectmanager cvs fakevim git
	madde mercurial perforce qnx subversion valgrind)
IUSE="debug doc examples test ${QTC_PLUGINS[@]%:*}"

# minimum Qt version required
QT_PV="4.8.0:4"

CDEPEND="
	=dev-libs/botan-1.10*[threads]
	>=dev-qt/qtcore-${QT_PV}[ssl]
	>=dev-qt/qtdeclarative-${QT_PV}
	|| (
		( >=dev-qt/qtgui-4.8.5:4 dev-qt/designer:4 )
		( >=dev-qt/qtgui-${QT_PV} <dev-qt/qtgui-4.8.5:4 )
	)
	>=dev-qt/qthelp-${QT_PV}[doc?]
	>=dev-qt/qtscript-${QT_PV}
	>=dev-qt/qtsql-${QT_PV}
	>=dev-qt/qtsvg-${QT_PV}
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	test? ( >=dev-qt/qttest-${QT_PV} )
"
RDEPEND="${CDEPEND}
	>=sys-devel/gdb-7.2[python]
	examples? ( >=dev-qt/qtdemo-${QT_PV} )
"
PDEPEND="
	autotools? ( sys-devel/autoconf )
	bazaar? ( dev-vcs/bzr )
	cmake? ( dev-util/cmake )
	cvs? ( dev-vcs/cvs )
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )
	subversion? ( dev-vcs/subversion )
	valgrind? ( dev-util/valgrind )
"

src_prepare() {
	qt4-r2_src_prepare

	# disable unwanted plugins
	for plugin in "${QTC_PLUGINS[@]#[+-]}"; do
		if ! use ${plugin%:*}; then
			einfo "Disabling ${plugin%:*} plugin"
			sed -i -re "/(^|SUBDIRS\s+\+=)\s+plugin_${plugin#*:}\>/d" src/plugins/plugins.pro \
				|| die "failed to disable ${plugin} plugin"
		fi
	done

	# fix translations
	sed -i -e "/^LANGUAGES =/ s:=.*:= $(l10n_get_locales):" \
		share/qtcreator/translations/translations.pro || die
}

src_configure() {
	EQMAKE4_EXCLUDE="share/qtcreator/templates/*" \
	eqmake4 qtcreator.pro \
		IDE_LIBRARY_BASENAME="$(get_libdir)" \
		IDE_PACKAGE_MODE=1 \
		TEST=$(use test && echo 1 || echo 0) \
		USE_SYSTEM_BOTAN=1
}

src_test() {
	echo ">>> Test phase [QTest]: ${CATEGORY}/${PF}"
	cd tests/auto || die
	eqmake4 IDE_LIBRARY_BASENAME="$(get_libdir)"
	emake check
}

src_install() {
	emake INSTALL_ROOT="${ED}usr" install

	dodoc dist/{changes-*,known-issues}

	# install documentation
	if use doc; then
		emake docs
		insinto /usr/share/doc/${PF}
		doins share/doc/qtcreator/qtcreator{,-dev}.qch
		docompress -x /usr/share/doc/${PF}/qtcreator{,-dev}.qch
	fi

	# install desktop file
	make_desktop_entry qtcreator 'Qt Creator' QtProject-qtcreator 'Qt;Development;IDE'
}
