# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.6.0.ebuild,v 1.7 2011/03/05 18:09:14 xarthisius Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="Generic Linux input driver"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.6.3"
DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-2.6
	x11-proto/inputproto
	x11-proto/xproto"
