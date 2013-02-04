# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.23.ebuild,v 1.6 2013/02/04 10:00:49 ago Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.27"
DEPEND="${RDEPEND}"
