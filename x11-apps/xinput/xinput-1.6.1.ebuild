# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xinput/xinput-1.6.1.ebuild,v 1.10 2013/10/08 05:03:53 ago Exp $

EAPI=5
inherit xorg-2

DESCRIPTION="Utility to set XInput device parameters"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libX11-1.3
	x11-libs/libXext
	>=x11-libs/libXi-1.5.99.1
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-2.1.99.1"
