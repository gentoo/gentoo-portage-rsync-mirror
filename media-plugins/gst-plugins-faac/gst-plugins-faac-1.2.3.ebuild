# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-1.2.3.ebuild,v 1.3 2014/03/09 12:07:21 pacho Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="media-libs/faac"
DEPEND="${RDEPEND}"
