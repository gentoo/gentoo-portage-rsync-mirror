# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ofa/gst-plugins-ofa-0.10.22.ebuild,v 1.4 2012/12/02 16:26:57 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	media-libs/libofa"

DEPEND="${RDEPEND}"
