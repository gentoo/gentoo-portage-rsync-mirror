# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-mimic/gst-plugins-mimic-0.10.23.ebuild,v 1.7 2013/02/04 09:59:50 ago Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for the MIMIC codec"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libmimic-1.0.4"
DEPEND="${RDEPEND}"
