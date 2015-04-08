# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/opencsg/opencsg-1.3.2.ebuild,v 1.4 2013/03/02 21:37:49 hwoarang Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="The Constructive Solid Geometry rendering library"
HOMEPAGE="http://www.opencsg.org/"
SRC_URI="http://www.opencsg.org/OpenCSG-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="media-libs/glew dev-qt/qtcore:4"
DEPEND="${CDEPEND} sys-devel/gcc"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/OpenCSG-${PV}"

src_unpack() {
	unpack ${A}

	/bin/rm -Rf "${S}"/glew
}

src_prepare() {
	# We actually want to install somthing
	cat << EOF >> src/src.pro
include.path=/usr/include
include.files=../include/*
target.path=/usr/lib
INSTALLS += target include
EOF

}

src_configure() {
	 eqmake4 "${S}"/src/src.pro
}
