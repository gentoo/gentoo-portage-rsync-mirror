# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-sunbw2/xf86-video-sunbw2-1.1.0.ebuild,v 1.3 2006/10/11 00:27:00 dberkholz Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="BW2 video driver"
KEYWORDS="-* sparc"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	x11-proto/xproto"
