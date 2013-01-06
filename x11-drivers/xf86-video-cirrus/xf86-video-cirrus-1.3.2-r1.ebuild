# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-cirrus/xf86-video-cirrus-1.3.2-r1.ebuild,v 1.1 2012/03/18 15:42:58 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Cirrus Logic video driver"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.3.2-xorg-server-1.12.patch
	"${FILESDIR}"/${PN}-1.3.2-pcitag-declare.patch
	"${FILESDIR}"/${PN}-1.3.2-pcitag-redefine.patch
)
