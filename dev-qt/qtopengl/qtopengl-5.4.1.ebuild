# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtopengl/qtopengl-5.4.1.ebuild,v 1.1 2015/02/24 18:49:41 pesa Exp $

EAPI=5

QT5_MODULE="qtbase"
VIRTUALX_REQUIRED="test"

inherit qt5-build

DESCRIPTION="OpenGL support library for the Qt5 framework (deprecated)"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa"
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE="gles2"

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[debug=,gles2=,opengl]
	~dev-qt/qtwidgets-${PV}[debug=,gles2=,opengl]
	virtual/opengl
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/opengl
)

src_configure() {
	local myconf=(
		-opengl $(usex gles2 es2 desktop)
	)
	qt5-build_src_configure
}
