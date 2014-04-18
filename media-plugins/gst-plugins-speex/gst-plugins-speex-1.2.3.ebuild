# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-1.2.3.ebuild,v 1.8 2014/04/18 13:57:35 ago Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/speex-1.1.6"
DEPEND="${RDEPEND}"
