# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-void/xf86-input-void-1.4.0.ebuild,v 1.10 2012/11/30 05:44:33 heroxbd Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="null input driver"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.9.99.1"
DEPEND="${RDEPEND}"
