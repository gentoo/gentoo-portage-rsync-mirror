# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libreoffice-bin-debug/libreoffice-bin-debug-4.0.4.2.ebuild,v 1.1 2013/07/20 22:13:43 dilfridge Exp $

EAPI=5

BASE_AMD64_URI="mirror://gentoo/amd64-debug-"
BASE_X86_URI="mirror://gentoo/x86-debug-"

DESCRIPTION="LibreOffice, a full office productivity suite. Binary package, debug info."
HOMEPAGE="http://www.libreoffice.org"
SRC_URI_AMD64="
	kde? (
		!java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-kde-${PVR}.tar.xz )
		java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-kde-java-${PVR}.tar.xz )
	)
	gnome? (
		!java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-gnome-${PVR}.tar.xz )
		java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-gnome-java-${PVR}.tar.xz )
	)
	!kde? ( !gnome? (
		!java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-base-${PVR}.tar.xz )
		java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-base-java-${PVR}.tar.xz )
	) )
"
SRC_URI_X86="
	kde? (
		!java? ( ${BASE_X86_URI}${PN/-bin-debug}-kde-${PVR}.tar.xz )
		java? ( ${BASE_X86_URI}${PN/-bin-debug}-kde-java-${PVR}.tar.xz )
	)
	gnome? (
		!java? ( ${BASE_X86_URI}${PN/-bin-debug}-gnome-${PVR}.tar.xz )
		java? ( ${BASE_X86_URI}${PN/-bin-debug}-gnome-java-${PVR}.tar.xz )
	)
	!kde? ( !gnome? (
		!java? ( ${BASE_X86_URI}${PN/-bin-debug}-base-${PVR}.tar.xz )
		java? ( ${BASE_X86_URI}${PN/-bin-debug}-base-java-${PVR}.tar.xz )
	) )
"

SRC_URI="
	amd64? ( ${SRC_URI_AMD64} )
	x86? ( ${SRC_URI_X86} )
"

IUSE="gnome java kde"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND="=app-office/${PN/-debug}-${PVR}[gnome=,java=,kde=]"

RESTRICT="test strip"

S="${WORKDIR}"

src_configure() { :; }

src_compile() { :; }

src_install() {
	dodir /usr
	cp -aR "${S}"/usr/* "${ED}"/usr/ || die
}
