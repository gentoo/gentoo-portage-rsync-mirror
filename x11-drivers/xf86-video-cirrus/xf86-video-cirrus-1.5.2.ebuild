# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-cirrus/xf86-video-cirrus-1.5.2.ebuild,v 1.6 2013/10/08 05:05:52 ago Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Cirrus Logic video driver"
KEYWORDS="alpha amd64 ia64 ppc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
