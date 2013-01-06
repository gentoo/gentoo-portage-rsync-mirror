# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-modplug/gst-plugins-modplug-0.10.22.ebuild,v 1.5 2012/12/02 16:22:45 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="media-libs/libmodplug
	>=media-libs/gst-plugins-base-0.10.33:0.10"
DEPEND="${RDEPEND}"
