# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.22.ebuild,v 1.9 2012/12/02 16:18:59 eva Exp $

EAPI="1"

inherit gst-plugins-bad

KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
