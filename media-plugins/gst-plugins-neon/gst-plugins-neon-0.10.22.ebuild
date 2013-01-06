# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.22.ebuild,v 1.6 2012/12/02 16:26:28 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.27
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
