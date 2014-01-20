# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdcraw/libkdcraw-4.11.5.ebuild,v 1.2 2014/01/20 08:00:21 kensington Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-libs/libraw-0.15:=
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.10.90-extlibraw.patch" )
