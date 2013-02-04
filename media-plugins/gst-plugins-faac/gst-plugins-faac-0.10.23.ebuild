# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-faac/gst-plugins-faac-0.10.23.ebuild,v 1.8 2013/02/04 09:55:02 ago Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~arm ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="media-libs/faac"
DEPEND="${RDEPEND}"
