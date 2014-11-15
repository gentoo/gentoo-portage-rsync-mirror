# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/designer/designer-4.8.6-r1.ebuild,v 1.1 2014/11/15 02:34:35 pesa Exp $

EAPI=5

inherit eutils qt4-build-multilib

DESCRIPTION="WYSIWYG tool for designing and building Qt-based GUIs"

if [[ ${QT4_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
fi

DESIGNER_PLUGINS="declarative phonon qt3support webkit"
IUSE="${DESIGNER_PLUGINS}"

DEPEND="
	~dev-qt/qtcore-${PV}[aqua=,debug=,${MULTILIB_USEDEP}]
	~dev-qt/qtgui-${PV}[aqua=,debug=,${MULTILIB_USEDEP}]
	~dev-qt/qtscript-${PV}[aqua=,debug=,${MULTILIB_USEDEP}]
	declarative? ( ~dev-qt/qtdeclarative-${PV}[aqua=,debug=,${MULTILIB_USEDEP}] )
	phonon? ( ~dev-qt/qtphonon-${PV}[aqua=,debug=,${MULTILIB_USEDEP}] )
	qt3support? ( ~dev-qt/qt3support-${PV}[aqua=,debug=,${MULTILIB_USEDEP}] )
	webkit? ( ~dev-qt/qtwebkit-${PV}[aqua=,debug=,${MULTILIB_USEDEP}] )
"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="tools/designer"

src_prepare() {
	qt4-build-multilib_src_prepare

	local plugin
	for plugin in ${DESIGNER_PLUGINS}; do
		use ${plugin} || sed -i -e "/\<${plugin}\>/d" \
			tools/designer/src/plugins/plugins.pro || die
	done
}

multilib_src_configure() {
	local myconf=(
		-system-libpng -system-libjpeg -system-zlib
		-no-sql-mysql -no-sql-psql -no-sql-ibase -no-sql-sqlite -no-sql-sqlite2 -no-sql-odbc
		-sm -xshape -xsync -xcursor -xfixes -xrandr -xrender -mitshm -xinput -xkb
		-fontconfig -no-svg -no-webkit -no-phonon -no-opengl
	)
	qt4_multilib_src_configure
}

multilib_src_install_all() {
	qt4_multilib_src_install_all

	doicon tools/designer/src/designer/images/designer.png
	make_desktop_entry designer Designer designer 'Qt;Development;GUIDesigner'
}
