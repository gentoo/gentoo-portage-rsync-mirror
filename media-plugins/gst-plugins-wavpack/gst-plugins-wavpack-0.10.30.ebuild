# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.30.ebuild,v 1.8 2012/12/02 16:41:12 eva Exp $

EAPI="3"

inherit gst-plugins-good

KEYWORDS="alpha amd64 hppa ppc ppc64 x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-sound/wavpack-4.40"
DEPEND="${RDEPEND}"
