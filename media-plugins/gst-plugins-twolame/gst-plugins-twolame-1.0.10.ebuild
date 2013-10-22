# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-twolame/gst-plugins-twolame-1.0.10.ebuild,v 1.7 2013/10/22 07:21:49 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/twolame-0.3.10"
DEPEND="${RDEPEND}"
