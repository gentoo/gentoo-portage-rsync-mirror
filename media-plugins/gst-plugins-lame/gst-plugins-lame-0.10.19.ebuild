# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-lame/gst-plugins-lame-0.10.19.ebuild,v 1.10 2013/02/07 13:13:53 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=media-sound/lame-3.95"
DEPEND="${RDEPEND}"
