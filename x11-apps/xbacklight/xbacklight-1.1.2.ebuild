# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xbacklight/xbacklight-1.1.2.ebuild,v 1.8 2012/05/15 14:12:26 aballier Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Sets backlight level using the RandR 1.2 BACKLIGHT output property"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libXrandr-1.2
	x11-libs/libX11"
DEPEND="${RDEPEND}"
