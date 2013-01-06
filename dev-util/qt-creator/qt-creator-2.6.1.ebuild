# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qt-creator/qt-creator-2.6.1.ebuild,v 1.1 2012/12/30 21:47:18 pesa Exp $

EAPI=4

PLOCALES="cs de fr hu ja pl ru sl zh_CN"

inherit eutils flag-o-matic l10n multilib qt4-r2

DESCRIPTION="Lightweight IDE for C++ development centering around Qt"
HOMEPAGE="http://qt-project.org/wiki/Category:Tools::QtCreator"
LICENSE="LGPL-2.1"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git
		https://git.gitorious.org/${PN}/${PN}.git"
else
	MY_PV=${PV/_/-}
	MY_P=${PN}-${MY_PV}-src
	SRC_URI="http://releases.qt-project.org/qtcreator/${MY_PV}/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
fi

SLOT="0"
KEYWORDS="~amd64 ~x86"

QTC_PLUGINS=(android autotools:autotoolsprojectmanager bazaar
	clearcase cmake:cmakeprojectmanager cvs fakevim git
	madde mercurial perforce qnx subversion valgrind)
IUSE="+botan-bundled debug doc examples ${QTC_PLUGINS[@]%:*}"

# minimum Qt version required
QT_PV="4.8.0:4"

CDEPEND="
	>=x11-libs/qt-assistant-${QT_PV}[doc?]
	>=x11-libs/qt-core-${QT_PV}[ssl]
	>=x11-libs/qt-declarative-${QT_PV}
	>=x11-libs/qt-gui-${QT_PV}
	>=x11-libs/qt-script-${QT_PV}
	>=x11-libs/qt-sql-${QT_PV}
	>=x11-libs/qt-svg-${QT_PV}
	debug? ( >=x11-libs/qt-test-${QT_PV} )
	!botan-bundled? ( >=dev-libs/botan-1.10.2 )
"
DEPEND="${CDEPEND}
	!botan-bundled? ( virtual/pkgconfig )
"
RDEPEND="${CDEPEND}
	>=sys-devel/gdb-7.2[python]
	examples? ( >=x11-libs/qt-demo-${QT_PV} )
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

	if ! use botan-bundled; then
		# identify system botan and pkg-config file
		local botan_version=$(best_version dev-libs/botan | cut -d '-' -f3 | cut -d '.' -f1,2)
		local lib_botan=$(pkg-config --libs botan-${botan_version})
		einfo "Major version of system's botan library to be used: ${botan_version}"

		# drop bundled libBotan. Bug #383033
		rm -rf "${S}"/src/libs/3rdparty/botan || die
		# remove references to bundled botan
		sed -i -e "s:botan::" "${S}"/src/libs/3rdparty/3rdparty.pro || die
		for x in testrunner parsertests modeldemo; do
			sed -i -e "/botan.pri/d" "${S}"/tests/valgrind/memcheck/${x}.pro || die
		done
		sed -i -e "/botan.pri/d" "${S}"/src/libs/utils/utils_dependencies.pri || die
		sed -i -e "/botan.pri/d" "${S}"/tests/manual/preprocessor/preprocessor.pro || die
		# link to system botan
		sed -i -e "/LIBS/s:$: ${lib_botan}:" "${S}"/qtcreator.pri || die
		sed -i -e "s:-lBotan:${lib_botan}:" "${S}"/tests/manual/appwizards/appwizards.pro || die
		# append botan refs to compiler flags
		append-flags $(pkg-config --cflags --libs botan-${botan_version})
	fi
}

src_configure() {
	eqmake4 qtcreator.pro \
		IDE_LIBRARY_BASENAME="$(get_libdir)" \
		IDE_PACKAGE_MODE=yes
}

src_compile() {
	emake
	use doc && emake docs
}

src_install() {
	emake INSTALL_ROOT="${ED}usr" install

	dodoc dist/{changes-2.*,known-issues}

	# Install documentation
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins share/doc/qtcreator/qtcreator{,-dev}.qch
		docompress -x /usr/share/doc/${PF}/qtcreator{,-dev}.qch
	fi

	# Install desktop file
	make_desktop_entry qtcreator 'Qt Creator' QtProject-qtcreator 'Qt;Development;IDE'
}
