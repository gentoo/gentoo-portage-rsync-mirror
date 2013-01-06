# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-keyboard/xf86-input-keyboard-1.6.2.ebuild,v 1.11 2013/01/04 17:54:13 jer Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Keyboard input driver"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.6.3"
DEPEND="${RDEPEND}"
