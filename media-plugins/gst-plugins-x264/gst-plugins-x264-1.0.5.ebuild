# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-x264/gst-plugins-x264-1.0.5.ebuild,v 1.13 2013/06/19 15:08:46 jer Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 sparc x86 ~amd64-fbsd"
IUSE=""

# 20111220 ensures us X264_BUILD >= 120
RDEPEND=">=media-libs/x264-0.0.20111220"
DEPEND="${RDEPEND}"
