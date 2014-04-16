# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvdread/gst-plugins-dvdread-1.2.3.ebuild,v 1.6 2014/04/16 07:48:04 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libdvdread"
DEPEND="${RDEPEND}"
