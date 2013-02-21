# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-resindvd/gst-plugins-resindvd-1.0.5.ebuild,v 1.5 2013/02/21 22:25:31 ago Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND="
	>=media-libs/libdvdnav-4.1.2
	>=media-libs/libdvdread-4.1.2
"
DEPEND="${RDEPEND}"
