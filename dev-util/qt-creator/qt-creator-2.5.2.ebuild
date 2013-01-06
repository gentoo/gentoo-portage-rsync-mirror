# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qt-creator/qt-creator-2.5.2.ebuild,v 1.6 2012/09/18 17:58:31 johu Exp $

EAPI=4

LANGS="cs de es fr hu it ja pl ru sl uk zh_CN"

inherit multilib eutils flag-o-matic qt4-r2

DESCRIPTION="Lightweight IDE for C++ development centering around Qt"
HOMEPAGE="http://qt.nokia.com/products/developer-tools"
LICENSE="LGPL-2.1"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git
		https://git.gitorious.org/${PN}/${PN}.git"
else
	MY_P=${PN}-${PV/_/-}-src
	SRC_URI="http://get.qt.nokia.com/qtcreator/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
fi

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

QTC_PLUGINS=(autotools:autotoolsprojectmanager bazaar cmake:cmakeprojectmanager
	cvs fakevim git madde mercurial perforce subversion valgrind)
IUSE="+botan-bundled debug doc examples ${QTC_PLUGINS[@]%:*}"

QT_PV="4.7.4:4"

CDEPEND="
	>=x11-libs/qt-assistant-${QT_PV}[doc?]
	>=x11-libs/qt-core-${QT_PV}[private-headers(+),ssl]
	>=x11-libs/qt-declarative-${QT_PV}[private-headers(+)]
	>=x11-libs/qt-gui-${QT_PV}[private-headers(+)]
	>=x11-libs/qt-script-${QT_PV}[private-headers(+)]
	>=x11-libs/qt-sql-${QT_PV}
	>=x11-libs/qt-svg-${QT_PV}
	debug? ( >=x11-libs/qt-test-${QT_PV} )
	!botan-bundled? ( =dev-libs/botan-1.8* )
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
			sed -i -e "/^[[:space:]]\+plugin_${plugin#*:}/d" src/plugins/plugins.pro \
				|| die "failed to disable ${plugin} plugin"
		fi
	done

	if use perforce; then
		echo
		ewarn "You have enabled the perforce plugin."
		ewarn "In order to use it, you need to manually download the perforce client from"
		ewarn "  http://www.perforce.com/perforce/downloads/index.html"
		echo
	fi

	# fix translations
	sed -i -e "/^LANGUAGES/s:=.*:= ${LANGS}:" \
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
		IDE_PACKAGE_MODE=true
}

src_compile() {
	emake
	use doc && emake docs
}

src_install() {
	emake INSTALL_ROOT="${ED}usr" install

	# Install documentation
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins share/doc/qtcreator/qtcreator{,-dev}.qch
		docompress -x /usr/share/doc/${PF}/qtcreator{,-dev}.qch
	fi

	# Install icon & desktop file
	doicon src/plugins/coreplugin/images/logo/128/qtcreator.png
	make_desktop_entry qtcreator 'Qt Creator' qtcreator 'Qt;Development;IDE'

	# Remove unneeded translations
	local lang
	for lang in ${LANGS}; do
		if ! has ${lang} ${LINGUAS}; then
			rm "${ED}"usr/share/qtcreator/translations/qtcreator_${lang}.qm \
				|| eqawarn "Failed to remove ${lang} translation"
		fi
	done
}
